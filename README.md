# Note from developer

## FrontEnd - VueJS
1. เปิด Terminal & CMD เพื่อ CD เข้า Project
2. ใช้ command: npm install เพื่อติดตั้ง Package & Lib
3. ใช้ command: npm run start หรือ npm run start:dev
4. แก้ไขไฟล์ ./src/app.module.ts เพื่อแก้ไข Database Config
5. ใช้ command: npm run build เพื่อ Build Project สำหรับ Deploy ขึ้น Cloud/Server/Hosting

## BackEnd - NestJs
1. เปิด Terminal & CMD เพื่อ CD เข้า Project
2. ใช้ command: npm install เพื่อติดตั้ง Package & Lib
3. ใช้ command: npm run start
4. แก้ไขไฟล์ config.ts เพื่อเปลี่ยน API EndPoint
5. แก้ไขไฟล์ ./src/components/MapInfo.vue เพื่อแก้ไข Key Google Map ค้นหา "apiKey:" เพื่อแก้ไข Key
6. ใช้ command: npm run build เพื่อ Build Project สำหรับ Deploy ขึ้น Cloud/Server/Hosting

## Database - MySQL
1. ติดตั้ง Xampp v8.x.x ขึ้นไป เพื่อใช้สำหรับทำ WebServer Test
2. เปิดโปรแกรม Xampp Control เพื่อ Start: Apache & MySQL
3. Import ไฟล์ .SQL ในโฟลเดอร์  "# Database SQL\tracking_map_example.sql"
4. เมื่อ Import เรียบร้อยแล้วจะเจอ Table: site และข้อมูลตัวอย่างสำหรับทดสอบ

## Deployment - [None]

# Technical Interview Question: 01 Full Stack Flutter Sitelist Screen

## Objective

Develop a simple search Bangkok Drugstore site application with three screens: Map Pin Screen, Site List Screen and Site Detail Screen. This assignment will test your skills in both Frontend and Backend

Tech Stack:

1. Frontend - TypeScript, NextJS, VueJS
2. Backend - TypeScript, NestJS
3. Database - MongoDB (Optional)
4. Deployment - Docker, Docker Compose (Optional)

JSON Data:
Please use the following JSON data for your assignment. You will be constructing an API to deliver the data.

## Requirements

### Screen 1: Map pin screen

1. Display map and pin the location
2. Search by place names
3. Click `ยืนยันตำแหน่ง` to save the current location and move to `Site List Screen`\
Note: Please create your own Place API on google cloud.

### Screen 2: Site list Screen

1. Display a list of sites fetched from the provided JSON data.
2. Each site should show an necessary information.
3. The list should be sorted by site status from `Open` to `Closed` and distance from `Closest` to `Farthest`. The current location is from previous screen.
4. Click a `phone number` button to make phone-call
5. Include a `Back` button to return to `Map Pin Screen`.\
Note: Do not display when the site's location is zero.

### Screen 3: Site Detail Screen

1. When a site from `Site list Screen` is tapped, navigate to this screen.
2. Display a selected site pinned on map along with information according to provided figma link.
3. Deeplink to Google Map Application and provide the route from the current location to selected site, when click `นำทาง` button
4. Click a `phone number` button to make phone-call
5. Include a `Back` button to return to `Site List Screen`.

### Backend

1. Create necessary RESTful API Endpoints to be integrated with Frontend
2. Connect with database storing the sitelist

## Evaluation Criteria

### Code Quality

1. *Write clean, readable, and maintainable code.
2. Follow best practices for NextJS and NestJS development.
3. Include comments and documentation where necessary.

### Functionality

1. Ensure that all screens are fully functional and interactive.
2. Use a state management solution to manage the state of the app.
3. Apply the best practice for building an API
4. Handle edge cases and potential errors (e.g., invalid input, network issues).

### Performance

1. Follow Material Design guidelines.
2. Optimize the application for performance and scalability.
3. Ensure that state changes are reflected in the UI without unnecessary rebuilds.
4. Ensure a responsive layout that looks good on both compact and large screen phones.
5. Use appropriate React components for lists, forms, and navigation.

### Testing (Bonus Point)

1. Write unit tests and widget tests to verify the functionality of your app.
2. Write unit tests for backend service.
3. Ensure at least 80% code coverage.

## Deliverables

- Submit your complete project as a GitHub repository link
- Ensure the repository includes a README file with instructions on how to run the app.
- A short video demonstrating the functionality of the application.
