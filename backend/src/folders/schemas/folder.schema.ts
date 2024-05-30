import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Types } from "mongoose";

@Schema()
export class Folder {

    @Prop()
    title:string;
    
    @Prop({default:0}) // Fix: Changed 'defualt' to 'default'
    notesCount:number;

    @Prop()
    userId:string;

    @Prop()
    noteIds:string[];
}

export type FolderDocument= Folder & Document;
export const FolderSchema = SchemaFactory.createForClass(Folder);
FolderSchema.index({ userId: 1 });
