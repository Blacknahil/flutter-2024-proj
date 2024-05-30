import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Note, NoteDocument } from 'src/notes/schemas/note.schema';
import { Role } from 'src/roles/role.enum';
import { User, UserDocument } from 'src/users/schemas/user.schema';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class AdminService {
  constructor(
    @InjectModel(Note.name) private readonly noteModel: Model<NoteDocument>,
    private readonly usersService: UsersService,
    @InjectModel(User.name) private readonly userModel: Model<UserDocument>,
  ) {}

  async getAllUsersWithNotes(): Promise<{ [userId: string]: { id:String,name: string, email: string, role: string, banned: boolean, foldersArray: any[] } }> {
    const allUsers = await this.usersService.findAll();
    const result: { [userId: string]: {id:string, name: string, email: string, role: string, banned: boolean, foldersArray: any[],} } = {};

    for (const user of allUsers) {
        const userId = user._id.toString();
        result[userId] = {
            id:userId,
            name: user.name,
            email: user.email,
            role: user.role,
            banned: user.banned,
            foldersArray: user.foldersArray,
        };
    }

    return result;
}


  //
  async deleteUserAndNotes(userId: string): Promise<void> {
    const user = await this.userModel.findById(userId);
    if (!user) {
      throw new NotFoundException('User not found');
    }

    const userNotes = await this.noteModel.find({ userId }).exec();

    for (const note of userNotes) {
      await this.noteModel.findByIdAndDelete(note._id).exec();
    }

    //delete user
    await this.userModel.findByIdAndDelete(userId);
    console.log('successfully delted user and user data');
  }

  async deleteNote(noteId: string): Promise<boolean> {
    const deletednote = await this.noteModel.findByIdAndDelete(noteId).exec();
    if (!deletednote) {
      throw new NotFoundException('Note is not found');
    }
    return true;
  }

  async banUser(userId:string){
    const  user = await this.userModel.findById(userId);
    if(!userId){
      throw new NotFoundException("User not found.")
    }

    if (user.role==Role.Admin){
      throw new BadRequestException("Admin can not be banned")

    }

    user.banned=true;
    await user.save();

    return `User with name ${user.name} has been banned`;
  }

  async unBanUser(userId:string):Promise<string>{
    const user= await this.userModel.findById(userId)
    if(!user){
      throw new NotFoundException("User not found")
    }
    user.banned=false
    await user.save()

    return `User with name ${user.name} has given access(UNBANNED).`;
  }
}
