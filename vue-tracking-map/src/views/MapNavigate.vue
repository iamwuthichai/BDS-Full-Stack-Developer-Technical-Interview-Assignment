<template>
  <MainLayout :headerTitle="location_name">
    <div class="min-h-screen">
      <!-- Address Section -->
      <div class="bg-white shadow p-4 my-2 mx-4 rounded-md">
        <h2 class="text-gray-700 font-semibold mb-2">ที่อยู่</h2>
        <p class="text-gray-600 text-sm">
          {{ address }}
        </p>
      </div>

      <!-- Use Component -->
      <MapInfo
        v-model:address="address"
        :btnDisabled="btnDisabled"
        :branchInfoDisabled="branchInfoDisabled"
        :initialPosition="initialPosition"
        :siteInfo="siteInfo"
        :siteLocationInfoInfoDisabled="siteLocationInfoInfoDisabled"
      />

    </div>

  </MainLayout>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { RouterLink, RouterView } from "vue-router";

import MainLayout from "@/components/layouts/MainLayout.vue";
import MapInfo from "../components/MapInfo.vue";

// Customer UI Component
const buttonClass = ref<string>("flex items-center justify-center w-full items-center justify-center sm:w-auto lg:w-auto p-2 bg-blue-500 hover:bg-blue-600 text-white shadow-lg text-sm sm:text-base rounded-full ");
const buttonLinkClass = ref<string>("flex items-center justify-center w-full items-center justify-center sm:w-auto lg:w-auto p-2 bg-gray-100 hover:bg-gray-200 text-blue-500 shadow-lg text-sm sm:text-base rounded-full border border-blue-500");

const btnDisabled = ref(true);
const branchInfoDisabled = ref(true);
const siteLocationInfoInfoDisabled = ref(false);
const address = ref<string | null>(null);
const initialPosition = ref<object>({});

// รับ Params
const latitude = new URLSearchParams(window.location.search).get('latitude');
const longitude = new URLSearchParams(window.location.search).get('longitude');
const location_name = new URLSearchParams(window.location.search).get('location_name');
const contact = new URLSearchParams(window.location.search).get('contact');
const open_time = new URLSearchParams(window.location.search).get('open_time');
const close_time = new URLSearchParams(window.location.search).get('close_time');

// สำหรับคำนวณระยะทาง
const currentLat = ref<number | null>(null);
const currentLng = ref<number | null>(null);
const destinationLat = latitude; // พิกัดปลายทาง (กรุงเทพฯ)
const destinationLng = longitude;
const distance = ref<number | null>(0);

// Set Props
initialPosition.value = {
  lat: parseFloat(latitude),
  lng: parseFloat(longitude)
};
const siteInfo = {
  site_location_name: location_name,
  site_open_time: open_time,
  site_close_time: close_time,
  site_contact: contact,
  site_distance: distance,
  openGoogleMap: openGoogleMap,
}

function formatPhoneNumber(phone: string): string {
  // ลบอักษรพิเศษทั้งหมด (เว้นแค่ +)
  const formattedPhone = phone.replace(/[^0-9+]/g, '');

  // ตรวจสอบและเติม +66 ที่หน้าเบอร์โทรศัพท์ (กรณีเป็นหมายเลขของไทย)
  if (formattedPhone.startsWith('0')) {
    return '+66' + formattedPhone.substring(1);
  }

  return formattedPhone;
}

// ฟังก์ชันสำหรับคำนวณระยะทางด้วย Haversine
function calculateDistance(lat1: number, lng1: number, lat2: number, lng2: number): number {
  const R = 6371; // รัศมีโลก (กิโลเมตร)
  const toRad = (value: number) => (value * Math.PI) / 180;

  const dLat = toRad(lat2 - lat1);
  const dLng = toRad(lng2 - lng1);

  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLng / 2) ** 2;

  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return parseInt(R * c); // ระยะทาง (กิโลเมตร)
}

// ดึงพิกัดตำแหน่งปัจจุบัน
onMounted(() => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      currentLat.value = position.coords.latitude;
      currentLng.value = position.coords.longitude;

      if (currentLat.value && currentLng.value) {
        distance.value = calculateDistance(
          currentLat.value,
          currentLng.value,
          destinationLat,
          destinationLng
        );
      }
    });
  } else {
    alert("เบราว์เซอร์นี้ไม่รองรับการดึงตำแหน่ง");
  }
});

function openGoogleMap() {
  const url = `https://www.google.com/maps?q=${latitude},${longitude}`;
  window.open(url, "_blank"); // เปิด Google Maps ในแท็บใหม่
}

</script>

<style scoped>

</style>
