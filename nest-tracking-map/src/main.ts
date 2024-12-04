import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // ตั้งค่า prefix /api สำหรับทุก route
  app.setGlobalPrefix('api');
  
  app.enableCors();
  
  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
