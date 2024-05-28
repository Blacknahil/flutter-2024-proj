import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import {Folder } from '../../folders/schemas/folder.schema';
import { IsMongoId } from 'class-validator';

// export type noteDocument =HydratedDocument<note>;

@Schema({timestamps:true})
export class Note {
  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  content: string;

  @Prop()
  userId: string;

  @Prop()
  folderId: string;

  //Time stamps
  // @Prop({ default: Date.now })
  // createdAt: Date;

  // @Prop({ default: Date.now })
  // updatedAt: Date;

  @Prop()
  notesid: Types.ObjectId;

}
export type NoteDocument = Note & Document;
export const NoteSchema = SchemaFactory.createForClass(Note);
