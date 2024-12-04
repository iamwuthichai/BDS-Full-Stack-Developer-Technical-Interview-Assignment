<template>
  <MainLayout>
    <!-- Header -->
    <div class="text-center mb-6">
      <!-- Search Input -->
      <div class="relative">
        <input
          class="placeholder:italic placeholder:text-slate-400 block bg-white w-full border border-slate-300 py-2 pl-9 pr-3 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1 sm:text-sm rounded-full text-black"
          placeholder="ค้นหาที่อยู่จัดส่งสินค้า"
          type="text"
          name="search"
          v-model="searchQuery"
          @input="filterLocations"
        />
        <ul
          v-if="filteredLocations.length"
          class="absolute bg-white border border-gray-300 mt-2 w-full max-h-48 overflow-y-auto shadow-lg rounded-md z-10 transition-all duration-200"
        >
          <li
            v-for="location in filteredLocations"
            :key="location.id"
            @click="selectLocation(location)"
            class="px-4 py-2 text-black hover:bg-blue-100 cursor-pointer"
          >
            {{ location.site_name }} (เวลาเปิดปิดร้าน: {{ location.site_open_time }}-{{ location.site_close_time }})
          </li>
        </ul>
      </div>
    </div>

    <!-- Branch List -->
    <div class="space-y-4">
      <!-- Branch Item -->
      <div class="p-4 bg-white shadow-md rounded-lg" v-for="siteInfo in filteredLocations.length ? filteredLocations : sites" :key="siteInfo.id">
        <div class="flex items-start space-x-4">
          <div class="text-blue-500">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
            </svg>
          </div>
          <div class="flex-1">
            <h2 class="text-lg font-semibold text-gray-800">{{ siteInfo.site_name }}</h2>
            <p class="text-gray-600">ระยะทาง: - กม.</p>
            <p class="text-gray-600">เวลาเปิด-ปิดร้าน: <span class="font-bold">{{ siteInfo.site_open_time }} - {{ siteInfo.site_close_time }}</span></p>
          </div>

        </div>

      <hr class="my-2 w-full">
      <div class="container">
        <RouterLink :class="buttonClass"
          :to="{
            name: 'confirm_and_navigate',
            query: {
              latitude: siteInfo.latitude,
              longitude: siteInfo.longitude,
              location_name: siteInfo.site_name,
              address: siteInfo.site_address,
              contact: siteInfo.site_tel,
              open_time: siteInfo.site_open_time,
              close_time: siteInfo.site_close_time,
            }
          }">
        <Button class="flex">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 sm:w-6 sm:h-6 mr-2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
          </svg>
          แผนที่สาขา
        </Button>
        </RouterLink>
        <ButtonLink :class="buttonLinkClass">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 sm:w-6 sm:h-6 mr-2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 0 0 2.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 0 1-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 0 0-1.091-.852H4.5A2.25 2.25 0 0 0 2.25 4.5v2.25Z" />
          </svg>
          โทร: {{ siteInfo.site_tel }}
        </ButtonLink>
      </div>

      </div>
    </div>
  </MainLayout>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { fetchSites } from "@/services/siteService";
import type { SiteInterface } from "@/services/types/Site";

import MainLayout from "@/components/layouts/MainLayout.vue";
import Button from "@/components/ui/Button.vue";
import ButtonLink from "@/components/ui/ButtonLink.vue";

// Customer UI Component
const buttonClass = ref<string>("flex items-center justify-center w-full items-center justify-center sm:w-auto lg:w-auto p-2 bg-blue-500 hover:bg-blue-600 text-white shadow-lg text-sm sm:text-base rounded-full ");
const buttonLinkClass = ref<string>("flex items-center justify-center w-full items-center justify-center sm:w-auto lg:w-auto p-2 bg-gray-100 hover:bg-gray-200 text-blue-500 shadow-lg text-sm sm:text-base rounded-full border border-blue-500");

// รับ Params
const sitename = new URLSearchParams(window.location.search).get('sitename');
const searchQuery = ref<string>(sitename || "");
const sites = ref<SiteInterface[]>([]);
const filteredLocations = ref<SiteInterface[]>([]);

const loadSites = async () => {
  // โหลดข้อมูลจาก API หรือฐานข้อมูล
  sites.value = await fetchSites();
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

const filterLocations = () => {
  const query = searchQuery.value.trim().toLowerCase(); // ปรับเป็นตัวพิมพ์เล็กเพื่อให้ค้นหาไม่คำนึงถึงตัวพิมพ์
  filteredLocations.value = query
    ? sites.value.filter((location) =>
        location.site_name.toLowerCase().includes(query)
      )
    : [];
};

const selectLocation = (location: SiteInterface) => {
  const locationInfo = `${location.site_name} | ${location.site_address}`;
  searchQuery.value = locationInfo;
  filteredLocations.value = []; // เคลียร์ผลลัพธ์ที่กรอง
};

onMounted(loadSites);
</script>

<style scoped>
.size-6 {
  height: 1.5rem;
  width: 1.5rem;
}
.container {
  display: grid;
  grid-template-columns: repeat(2, 1fr); /* แบ่งช่องเป็น 3 คอลัมน์ */
  gap: 10px;
}

</style>
