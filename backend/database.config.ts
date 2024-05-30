
// database.config.ts
// import mongoose from 'mongoose';

// export const connectToDatabase = async () => {
//   try {
//     await mongoose.connect('mongodb://localhost:27017', {
//       useNewUrlParser: true,
//       useUnifiedTopology: true,
//     } as mongoose.ConnectOptions);
//     console.log('Connected to MongoDB');
//   } catch (error) {
//     console.log("CANT CONNECT TO DATABASE ")
//     console.error('Error connecting to MongoDB:', error);

//   }
// };

// database.config.ts
import { MongooseModuleOptions } from '@nestjs/mongoose';

export const createMongooseOptions = (): MongooseModuleOptions => {
  return {
    uri: 'mongodb://localhost:27017/notes_app', // Replace with your actual MongoDB connection string
  } as MongooseModuleOptions;
};
