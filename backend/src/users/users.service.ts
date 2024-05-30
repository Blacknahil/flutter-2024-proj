import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateUsersDto } from './dto/create-users.dto';
import { InjectModel } from '@nestjs/mongoose';
import { User, UserDocument } from './schemas/user.schema';
import { Model } from 'mongoose';
import { UpdateUsersDto } from './dto/update-users.dto';
import { LoginUserDto } from './dto/login-users.dto';
import * as bcrypt from 'bcrypt';
import { Role } from 'src/roles/role.enum';

@Injectable()
export class UsersService {
  // constructor(private readonly rolesService:RolesService){}
  constructor(
    @InjectModel(User.name) private readonly userModel: Model<UserDocument>,
  ) {}

  async register(createUserDto: CreateUsersDto): Promise<User> {
    const existingUser = await this.userModel
      .findOne({ email: createUserDto.email })
      .exec();
    if (existingUser) {
      throw new ConflictException('Email already exists');
    }

    const createdUser = new this.userModel({
      ...createUserDto,
      role: Role.User,
    });
    return createdUser.save();
  }

  async findAll(): Promise<User[]> {
    return this.userModel.find().exec();
  }

  // async profile

  async profile(userId: string): Promise<User> {
    const user = await this.userModel.findById(userId).select('-password').exec();
    console.log(user)

    if (!user) {
      console.log('User Not found WE cant get the user');
      throw new NotFoundException('User Not found WE cant get the user');
    }
    return user;
  }

  //update profile

  async updateProfile( userId: string,updateUserDto: UpdateUsersDto): Promise<string> {
    const user= await this.userModel.findById(userId);
    if (!user){
      throw new NotFoundException("User not found")
    }

    let updatedFields = '';

    if (updateUserDto.name){
      user.name=updateUserDto.name;
      updatedFields+="Username updated."
    }
    if (updateUserDto.newPassword){
      if (updateUserDto.newPassword!==updateUserDto.confirmPassword){
        throw new BadRequestException("New password and confirm password dont match")
      }
      const isOldPasswordCorrect= await bcrypt.compare(updateUserDto.oldPassword,updateUserDto.newPassword)

      if (!isOldPasswordCorrect){
        throw new BadRequestException("Old password is incorrct")
      }
      user.password= await bcrypt.hash(updateUserDto.newPassword,10)
      updatedFields+="Password updated."

    }

    await user.save()
    if (updatedFields==""){
      return "No updates were made as no valid fields were provided"
    }
    return updatedFields;
    
  }


  
  async deleteAccount(userId: string,user:User): Promise<User> {

    const userToDelete = await this.userModel
      .findById(userId);

    if (!userToDelete) {
      throw new NotFoundException('user not found');
    }
    if (user._id.toString() !=userId && user.role!=Role.Admin){
      throw new ForbiddenException("You dont have access to delete the user")
    }
    await this.userModel.deleteOne({_id:userId})
    return userToDelete;
  }



  async findByEmail(email: string): Promise<User | null> {
    return this.userModel.findOne({ email }).exec();
  }

  async findAdminUsers(): Promise<User[]> {
    return this.userModel.find({ role: Role.Admin }).exec();
  }


  async createAdmin(adminData: {
    name: string;
    email: string;
    password: string;
    role: Role;
  }) {
    const admins = await this.findAdminUsers();
    const hashedPassword = await bcrypt.hash(adminData.password, 10);
    const admin = new this.userModel({
      ...adminData,
      id: admins.length + 1,
      password: hashedPassword,
    });
    return admin.save();
  }



  async findOne(id: string): Promise<User | undefined> {
    const user = this.userModel.findById(id);
    if (!user) {
      throw new BadRequestException('User not found');
    }
    return user;
  }



  async updateFoldersArray(userId:string,folderId:string){

    const user = await this.userModel.findById(userId);

    if (!user){
      throw new NotFoundException("User of id $userId not found!");

    }
    if (!user.foldersArray.includes(folderId)){
      user.foldersArray.push(folderId)
      await user.save();
    }
    
  }

  
  async removefolderIdformUser(userId:string,folderId){
    const user = await this.userModel.findById(userId);
    if(!user){
      throw new NotFoundException('User of id ${userId} not found');
    }

    const index =user.foldersArray.indexOf(folderId);
    if (index>-1){
      user.foldersArray.splice(index,1);
      await user.save();
    }

  }
}
