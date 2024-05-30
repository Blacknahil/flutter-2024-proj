import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { IntegerType } from "mongodb";
import { Types } from "mongoose";

@Schema()
export class Folder {

    @Prop()
    title:String;
    
    @Prop({default:0}) // Fix: Changed 'defualt' to 'default'
    notesCount:number;

    @Prop()
    userId:String;

    @Prop()
    noteIds:String[];
}

export type FolderDocument= Folder & Document;
export const FolderSchema = SchemaFactory.createForClass(Folder);
FolderSchema.index({ userId: 1 });
