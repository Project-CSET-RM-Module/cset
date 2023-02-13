//////////////////////////////// 
// 
//   Copyright 2023 Battelle Energy Alliance, LLC  
// 
// 
//////////////////////////////// 
using CSETWebCore.Business.GalleryParser;
using CSETWebCore.DataLayer.Model;
using CSETWebCore.Interfaces.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace CSETWebCore.Api.Controllers
{
#if DEBUG
    [ApiController]
    public class GalleryEditorController : ControllerBase
    {
        
        private readonly ITokenManager _token;        
        private CSETContext _context;
        private IGalleryEditor _galleryEditor;

        // if you want to use the gallery editor, change this to true
        private bool inDev = true;

        public GalleryEditorController(ITokenManager token, IGalleryEditor galleryEditor, CSETContext context)
        {
            _token = token;
            _context = context;
            _galleryEditor = galleryEditor;
        }
        [HttpPost]
        [Route("api/galleryEdit/updatePosition")]
        public IActionResult updatePosition(MoveItem moveItem)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                _context.Database.ExecuteSqlRaw("delete GALLERY_ROWS FROM[GALLERY_ROWS] AS[g] INNER JOIN[GALLERY_GROUP] AS[g0] ON[g].[Group_Id] = [g0].[Group_Id] left JOIN[GALLERY_GROUP_DETAILS] AS[g1] ON[g0].[Group_Id] = [g1].[Group_Id] WHERE g1.Column_Index is null");
                if (String.IsNullOrWhiteSpace(moveItem.fromId) && !string.IsNullOrWhiteSpace(moveItem.toId)){

                    //find the new group and insert it
                    //renumber both groups                    
                    var dbItem = _context.GALLERY_ITEM.Where(x => x.Gallery_Item_Id == moveItem.gallery_Item_Id).FirstOrDefault();
                    if (dbItem != null)
                    {
                        
                        var detailsNewList = _context.GALLERY_GROUP_DETAILS.Where(r => r.Group_Id == int.Parse(moveItem.toId)).OrderBy(r => r.Column_Index).ToList();
                        var newGroupItem = new GALLERY_GROUP_DETAILS()
                        {
                            Gallery_Item_Id = moveItem.gallery_Item_Id,
                            Column_Index = int.Parse(moveItem.newIndex),
                            Group_Id = int.Parse(moveItem.toId)
                        };
                        _context.GALLERY_GROUP_DETAILS.Add(newGroupItem);
                        detailsNewList.Insert(int.Parse(moveItem.newIndex), newGroupItem);
                        RenumberGroup(detailsNewList);
                        
                        _context.SaveChanges();
                    }
                    

                }
                else if (String.IsNullOrWhiteSpace(moveItem.fromId) || string.IsNullOrWhiteSpace(moveItem.toId))
                {

                    

                    //we are changing position of the rows. 
                    //move the item from the old index to the new index and then 
                    //update the indexes of everything below them.
                    var rows = (from r in _context.GALLERY_ROWS
                               where r.Layout_Name == moveItem.Layout_Name
                               orderby r.Row_Index
                               select r).ToList();
                    _context.GALLERY_ROWS.RemoveRange(rows);
                    _context.SaveChanges();
                    //question can I violate the primary key before I save? 
                    //if so then remove the old one and insert it at the new position.
                    //iterate through all the items and just reassign the row_index. 
                    var itemToMove = rows[int.Parse(moveItem.oldIndex)];
                    rows.Remove(itemToMove);
                    if (int.Parse(moveItem.oldIndex) < int.Parse(moveItem.newIndex))
                    {
                        //we are moving it down. so the new index needs to be -1
                        rows.Insert(int.Parse(moveItem.newIndex)-1, itemToMove);
                    }
                    else if(int.Parse(moveItem.oldIndex) > int.Parse(moveItem.newIndex))
                    {
                        //we are moving it up. so the new index is unchanged
                        rows.Insert(int.Parse(moveItem.newIndex), itemToMove);
                    }
                    
                    RenumberGroup(rows);
                    _context.GALLERY_ROWS.AddRange(rows);
                    _context.SaveChanges();
                }
                else if(moveItem.fromId == moveItem.toId)
                {
                    //the items is moved in the same group 
                    //find the group and move it
                    //get the group
                    var detailsList = _context.GALLERY_GROUP_DETAILS.Where(r => r.Group_Id == int.Parse(moveItem.fromId)).OrderBy(r=> r.Column_Index).ToList();
                    var itemToMove = detailsList[int.Parse(moveItem.oldIndex)];
                    detailsList.Remove(itemToMove);
                    detailsList.Insert(int.Parse(moveItem.newIndex), itemToMove);
                    RenumberGroup(detailsList);
                    _context.SaveChanges();
                }
                else
                {
                    //find the old group and remove it
                    //find the new group and insert it
                    //renumber both groups
                    var detailsOldList = _context.GALLERY_GROUP_DETAILS.Where(r => r.Group_Id == int.Parse(moveItem.fromId)).OrderBy(r => r.Column_Index).ToList();
                    var itemToMove = detailsOldList[int.Parse(moveItem.oldIndex)];                    
                    detailsOldList.Remove(itemToMove);
                    RenumberGroup(detailsOldList);                    
                    var detailsNewList = _context.GALLERY_GROUP_DETAILS.Where(r => r.Group_Id == int.Parse(moveItem.toId)).OrderBy(r => r.Column_Index).ToList();                    
                    detailsNewList.Insert(int.Parse(moveItem.newIndex), itemToMove);
                    RenumberGroup(detailsNewList);
                    itemToMove.Group_Id = int.Parse(moveItem.toId);                    
                    _context.SaveChanges();
                }

                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        private void RenumberGroup(List<GALLERY_GROUP_DETAILS> detailsList)
        {
            int i = 0;
            foreach (var item in detailsList)
            {
                item.Column_Index = i++;
            }
        }

        private void RenumberGroup(List<GALLERY_ROWS> rows)
        {
            int i = 0; 
            foreach(var row in rows)
            {
                row.Row_Index = i++;
            }
        }

        /// <summary>
        /// Clones the specified item
        /// </summary>
        /// <param name="Item_To_Clone"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/cloneItem")]
        public IActionResult CloneItem(int Item_To_Clone, int Group_Id)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                _galleryEditor.CloneGalleryItem(Item_To_Clone, Group_Id);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        /// <summary>
        /// Clones the specified item
        /// </summary>
        /// <param name="Item_To_Clone"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/cloneGroup")]
        public IActionResult CloneGroup(int Group_Id, string layout_Name)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                _galleryEditor.CloneGalleryGroup(Group_Id, layout_Name);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        /// <summary>
        /// Adds the item
        /// </summary>
        /// <param name="newIcon_File_Name_Small"></param>
        /// <param name="newIcon_File_Name_Large"></param>
        /// <param name="newDescription"></param>
        /// <param name="newTitle"></param>
        /// <param name="group_Id"></param>
        /// <param name="columnId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/addItem")]
        public IActionResult AddItem(string newDescription, string newTitle, int group_Id, int columnId)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            string newIcon_File_Name_Small = "";
            string newIcon_File_Name_Large = "";

            try
            {
                _galleryEditor.AddGalleryItem(newIcon_File_Name_Small, newIcon_File_Name_Large, newDescription, newTitle, group_Id, columnId);
                //_galleryEditor.AddGalleryDetail(columnId);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        /// <summary>
        /// Clones the specified item
        /// </summary>
        /// <param name="group"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/addGroup")]
        public IActionResult AddGroup(string group, string layout, string newDescription, string newTitle, int columnId)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            string newIcon_File_Name_Small = "";
            string newIcon_File_Name_Large = "";

            try
            {
                var group_id = _galleryEditor.AddGalleryGroup(group, layout);
                _galleryEditor.AddGalleryItem(newIcon_File_Name_Small, newIcon_File_Name_Large, newDescription, newTitle, group_id, columnId);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        /// <summary>
        /// Deletes the item
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/deleteGalleryItem")]
        public IActionResult DeleteItem(int id, int group_id)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                _galleryEditor.DeleteGalleryItem(id, group_id);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        
        [HttpGet]
        [Route("api/gallery/getlayouts")]
        public IActionResult GetLayouts()
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                
                return Ok(_galleryEditor.GetLayouts());
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        /// <summary>
        /// Deletes the item
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/deleteGalleryGroup")]
        public IActionResult DeleteGroup(int id, string layout)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                _galleryEditor.DeleteGalleryGroup(id, layout);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [HttpPost]
        [Route("api/galleryEdit/updateItem")]
        public IActionResult updateItem([FromBody] UpdateItem item)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                if (item.IsGroup)
                {
                    var galleryGroup = _context.GALLERY_GROUP.Where(x => x.Group_Id == item.Group_Id).FirstOrDefault();
                    if (galleryGroup == null) return BadRequest();

                    galleryGroup.Group_Title = item.Value;
                    _context.SaveChanges();
                }
                else
                {
                    var galleryItem = _context.GALLERY_ITEM.Where(x => x.Gallery_Item_Id == item.Group_Id).FirstOrDefault();
                    if (galleryItem == null) return BadRequest();

                    galleryItem.Title = item.Value;
                    _context.SaveChanges();
                }

                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        /// <summary>
        /// Returns the gallery card structure
        /// </summary>
        /// <param name="Layout_Name"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("api/gallery/getUnused")]
        public IActionResult GetUnusedItems(string Layout_Name)
        {
            if (!inDev)
            {
                return Ok(200);
            }
            try
            {
                return Ok(_galleryEditor.GetUnused(Layout_Name));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


    }

    public class MoveItem
    {
        public string Layout_Name { get; set; }
        public string fromId { get; set; }
        public string toId { get;set; }
        public string oldIndex { get; set; }
        public string newIndex { get; set; }
        public int gallery_Item_Id { get; set; }
    }

    public class UpdateItem
    {
        public bool IsGroup { get; set; }
        public int Group_Id { get; set; }

        public string Value { get; set; }
    }
#endif
}
