import { ForbiddenException, forwardRef, Inject, Injectable, NotFoundException } from '@nestjs/common';
import { CreateFolderDto } from './dto/create-folder.dto';
import { UpdateFolderDto } from './dto/update-folder.dto';
import { Model, Types } from 'mongoose';
import { Folder, FolderDocument } from './schemas/folder.schema';
import { InjectModel } from '@nestjs/mongoose';
import { UsersService } from 'src/users/users.service';
import { NotesService } from 'src/notes/notes.service';
// import { Type } from 'mongoose';

@Injectable()
export class FoldersService {

  constructor(
    @InjectModel(Folder.name) private readonly folderModel:Model<FolderDocument>,
    private readonly usersService:UsersService,
    @Inject(forwardRef(() => NotesService)) private readonly notesService: NotesService
){}


  async create(createFolderDto: CreateFolderDto,userId:Types.ObjectId){
    const { title } = createFolderDto;
    const createdFolder=new this.folderModel({title:title,userId:userId})

    await this.usersService.updateFoldersArray(userId.toString(),createdFolder._id.toString())
    await createdFolder.save();
    return createdFolder;
    console.log("Folder created successfully")


  }
  

  // findAllFolderName(:userId) {
  //   const 
    
  // }

  async findNotesByFolderId(folderId: string) {
    const notes = await this.notesService.getNotesByfolderId(folderId)
    return notes;
    
  }

  async update(id: string, updateFolderDto: UpdateFolderDto) {
    const existingFolder = await this.folderModel.findById(id);
  
    if (!existingFolder) {
      throw new NotFoundException(`Folder #${id} not found`);
    }
  
    if (updateFolderDto.title) {
      existingFolder.title = updateFolderDto.title;
    }
  
    if (updateFolderDto.notesIds) {
      
      existingFolder.noteIds.push(...updateFolderDto.notesIds.filter(noteId => !existingFolder.noteIds.includes(noteId)));
      existingFolder.notesCount =existingFolder.noteIds.length;
    }
  
    await existingFolder.save();
  
    return existingFolder;
  }



  async removeFolder(folderId: string,userId:string) {
    const folder=await this.folderModel.findById(folderId)
    if (!folder){
      throw new NotFoundException("Folder not in the folderModelSchema")
    }
    console.log(userId)
    if (folder.userId.toString() !==userId){
      throw new ForbiddenException("You dont own this folder")
    }
    await this.folderModel.deleteOne({_id:folderId});

    await this.notesService.deleteNotesByFolderId(folderId);
    console.log("Delete all notes with that folder id ")

    await this.usersService.removefolderIdformUser(userId,folderId);
    console.log("Removed the folder id from the users property")
    return `This action removes a #${folderId} folder`;
  }


  
  async removeNoteIdFromFolder(folderId: string, noteId: string): Promise<void> {
    const folder = await this.folderModel.findById(folderId);
    if (!folder) {
      throw new NotFoundException(`Folder of id ${folderId} not found`);
    }
  
    const index = folder.noteIds.indexOf(noteId);
    if (index > -1) {
      folder.noteIds.splice(index, 1);
      folder.notesCount-=1
      await folder.save();
    }
  }

}
