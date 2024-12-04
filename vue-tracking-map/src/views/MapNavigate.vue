<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Header -->
    <div class="bg-white shadow p-4">
      <div class="flex items-center">
        <RouterLink
          :to="{
            name: 'find_branch',
            query: {}
          }">
          <button class="text-blue-500 hover:text-blue-700">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
          </button>
        </RouterLink>
        <h1 class="flex-1 text-center text-lg font-semibold text-blue-600">
          {{ location_name }}
        </h1>
      </div>
    </div>

    <!-- Address Section -->
    <div class="bg-white shadow p-4 my-2 mx-4 rounded-md">
      <h2 class="text-gray-700 font-semibold mb-2">ที่อยู่</h2>
      <p class="text-gray-600 text-sm">
        {{ address }}
      </p>
    </div>

    <!-- Map Section -->
    <div class="my-4 mx-4 rounded-lg overflow-hidden">
      <MapInfo
        v-model:address="address"
        :btnDisabled="btnDisabled"
        :branchInfoDisabled="branchInfoDisabled"
        :initialPosition="initialPosition"
      />
    </div>

    <!-- Branch Info Section -->
    <div class="bg-white shadow p-4 mx-4 rounded-lg">
      <div class="flex items-center mb-2">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="blue" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
          <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
        </svg>
        <p class="ml-2 text-gray-700">สาขา: <span class="font-semibold">{{ location_name }}</span></p>
      </div>
      <div class="flex items-center mb-2">
        <p class="ml-2 text-gray-700">ระยะทาง: <span class="font-semibold"> {{ parseFloat(distance).toFixed(2) }} กม. </span></p>
      </div>
      <div class="flex items-center">
        <p class="ml-2 text-gray-700">เวลาเปิด-ปิดร้าน: <span class="font-semibold"> {{ open_time }} - {{ close_time }} </span></p>
      </div>

      <!-- Buttons Section -->
      <hr class="my-2">
      <div class="flex flex-wrap justify-center gap-4 mt-4 mx-4">
        <a href="tel:{{ formatPhoneNumber(contact) }}" class="flex items-center justify-center w-full sm:w-auto p-2 bg-gray-100 text-blue-500 border border-blue-500 hover:bg-gray-200 rounded-full shadow-lg text-sm sm:text-base">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 sm:w-6 sm:h-6 mr-2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 0 0 2.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 0 1-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 0 0-1.091-.852H4.5A2.25 2.25 0 0 0 2.25 4.5v2.25Z" />
          </svg>
          โทร: {{ contact }}
        </a>
        <button class="flex items-center justify-center w-full sm:w-auto px-6 py-2 bg-blue-500 text-white rounded-full hover:bg-blue-600 shadow-md"
        @click="openGoogleMap">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 sm:w-6 sm:h-6 mr-2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
          </svg>
          นำทาง
        </button>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { RouterLink, RouterView } from "vue-router";

import MainLayout from "@/components/layouts/MainLayout.vue";
import MapInfo from "../components/MapInfo.vue";
import Button from "@/components/ui/Button.vue";
import ButtonLink from "@/components/ui/ButtonLink.vue";

// Customer UI Component
const buttonClass = ref<string>("flex items-center justify-center w-full items-center justify-center sm:w-auto lg:w-auto p-2 bg-blue-500 hover:bg-blue-600 text-white shadow-lg text-sm sm:text-base rounded-full ");
const buttonLinkClass = ref<string>("flex items-center justify-center w-full items-center justify-center sm:w-auto lg:w-auto p-2 bg-gray-100 hover:bg-gray-200 text-blue-500 shadow-lg text-sm sm:text-base rounded-full border border-blue-500");

const btnDisabled = ref(true);
const branchInfoDisabled = ref(true);
const address = ref<string | null>(null);
const initialPosition = ref<object>({});

// รับ Params
const latitude = new URLSearchParams(window.location.search).get('latitude');
const longitude = new URLSearchParams(window.location.search).get('longitude');
const location_name = new URLSearchParams(window.location.search).get('location_name');
const contact = new URLSearchParams(window.location.search).get('contact');
const open_time = new URLSearchParams(window.location.search).get('open_time');
const close_time = new URLSearchParams(window.location.search).get('close_time');
initialPosition.value = {
  lat: parseFloat(latitude),
  lng: parseFloat(longitude)
};

function formatPhoneNumber(phone: string): string {
  // ลบอักษรพิเศษทั้งหมด (เว้นแค่ +)
  const formattedPhone = phone.replace(/[^0-9+]/g, '');

  // ตรวจสอบและเติม +66 ที่หน้าเบอร์โทรศัพท์ (กรณีเป็นหมายเลขของไทย)
  if (formattedPhone.startsWith('0')) {
    return '+66' + formattedPhone.substring(1);
  }

  return formattedPhone;
}

// สำหรับคำนวณระยะทาง
const currentLat = ref<number | null>(null);
const currentLng = ref<number | null>(null);
const destinationLat = latitude; // พิกัดปลายทาง (กรุงเทพฯ)
const destinationLng = longitude;
const distance = ref<number | null>(null);

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
  return R * c; // ระยะทาง (กิโลเมตร)
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
