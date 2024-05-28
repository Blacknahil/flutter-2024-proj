import { forwardRef, Inject, Injectable, NotFoundException } from '@nestjs/common';
import { Note, NoteDocument } from './schemas/note.schema';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { CreateNotesDto } from './dto/create-notes.dto';
import { UpdateNotesDto } from './dto/update-notes.dto';
import { FoldersService } from 'src/folders/folders.service';
import { UsersService } from 'src/users/users.service';
import { DeleteResult } from 'mongodb';

@Injectable()
export class NotesService {
  constructor(
    @InjectModel(Note.name) private readonly noteModel: Model<NoteDocument>,
    @Inject(forwardRef(() => FoldersService)) private readonly foldersService: FoldersService
  ) {}

  async create(createNoteDto: CreateNotesDto, headers: any): Promise<Note> {
    try {
      const userId = headers['user-id'];
      const folderId = headers['folder-id']
      createNoteDto.userId = userId;
      createNoteDto.folderId=folderId;

      const createdNote = new this.noteModel(createNoteDto);
      console.log('Note created successfully');

      await this.foldersService.update(folderId,{notesIds:[createdNote._id], notesCount:1});

      
      return createdNote.save();
    } catch (error) {
      console.error('Error creating note:', error);
      throw new Error('Unable to create note');
    }
  }

  async remove(id: string, userId: string): Promise<Note> {
    const deletedNote = await this.noteModel
      .findOneAndDelete({
        _id: id,
        userId,
      })
      .exec();
    if (!deletedNote) {
      throw new NotFoundException('Note not found');
    }

    console.log("Removing the note from the folder");
    const folderId = deletedNote.folderId;
    await this.foldersService.removeNoteIdFromFolder(folderId,id)

    return deletedNote;
  }

  async findById(id: string, userId: string): Promise<Note> {
    const note = await this.noteModel
      .findOne({
        _id: id,
        userId,
      })
      .exec();
    if (!note) {
      throw new NotFoundException('Note not found');
    }
    return note;
  }

  async findAll(userId: string): Promise<Note[]> {
    return this.noteModel.find({ userId }).exec();
  }

  async findAllNotesForAdmin(): Promise<Note[]> {
    return this.noteModel.find().exec();
  }

  async update(
    id: string,
    updateNoteDto: UpdateNotesDto,
    userId: string,
  ): Promise<Note> {
    const updatedNote = await this.noteModel
      .findOneAndUpdate(
        { _id: id, userId },
        { $set: { ...updateNoteDto, updatedAt: new Date() } },
        { new: true },
      )
      .exec();

    if (!updatedNote) {
      throw new NotFoundException('Note not found');
    }
    console.log('successful update');
    return updatedNote;
  }



  async getNotesByfolderId(folderId:string):Promise<Note []>{
    const notes= await this.noteModel.find(
      {folderId:folderId}
    ).select('title content createdAt updatedAt')
    .exec();
    return notes || [];
    }

    async deleteNotesByFolderId(folderId: string): Promise<DeleteResult> {
      const result = await this.noteModel.deleteMany({ folderId: folderId }).exec();
      return result;
    }
  }


