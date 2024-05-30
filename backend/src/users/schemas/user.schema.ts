import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Types } from 'mongoose';
import { Role } from 'src/roles/role.enum';

@Schema()
export class User {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  password: string;

  @Prop({ default: Date.now })
  createdAt: Date;

  @Prop({ default: Date.now })
  updatedAt: Date;

  @Prop({ required: true, unique: true })
  email: string;

  @Prop()
  best_friend: string;

  @Prop()
  role: Role;

  @Prop({default:false})
  banned:boolean

  _id: Types.ObjectId;

  @Prop()
  foldersArray:Array<string>
}

export type UserDocument = User & Document;

export const UserSchema = SchemaFactory.createForClass(User);
