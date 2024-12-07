<template>
  <div class="map-wrapper">
    <div id="map" class="map-container"></div>

    <!-- Branch Info -->
    <div :hidden="branchInfoDisabled"
      class="branch-info-container fixed bottom-5 left-1/2 transform -translate-x-1/2 bg-gray-100 text-black p-4 rounded-md shadow-lg text-lg cursor-pointer transition-all hover:bg-gray-200">
      <div>
        <div class="flex items-center mb-2">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
            class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
            <path stroke-linecap="round" stroke-linejoin="round"
              d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
          </svg>
          <p class="ml-2 text-gray-700">
            <p class="font-bold">ที่อยู่* (ตำบล, อำเภอ, จังหวัด, รหัสไปรษณีย์)</p>
            <span class="font-semibold">{{ address }}</span>
          </p>
        </div>

        <RouterLink :to="{ name: 'find_branch', query: { sitename: searchlocationName } }">
          <button
            class="my-2 min-w-full bottom-5 left-1/2 transform  bg-blue-500 text-white p-4 rounded-full shadow-lg text-lg cursor-pointer transition-all hover:bg-blue-600"
            @click="confirmLocation" :hidden="btnDisabled">
            ยืนยันตำแหน่ง
          </button>
        </RouterLink>
      </div>

    </div>

    <!-- Site Info -->
    <div :hidden="siteLocationInfoInfoDisabled" v-if="siteInfo"
    class="fixed bottom-5 left-1/2 transform -translate-x-1/2 text-black p-4 rounded-md shadow-lg text-lg cursor-pointer transition-all">
      <!-- Branch Info Section -->
      <div class="bg-white shadow p-4 mx-4 rounded-lg">
        <div class="flex items-center mb-2">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="blue" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
          </svg>
          <p class="ml-2 text-gray-700">สาขา: <span class="font-semibold">{{ siteInfo.site_location_name }}</span></p>
        </div>
        <div class="flex items-center mb-2">
          <p class="ml-2 text-gray-700">ระยะทาง: <span class="font-semibold"> {{ siteInfo.site_distance }} กม. </span></p>
        </div>
        <div class="flex items-center">
          <p class="ml-2 text-gray-700">เวลาเปิด-ปิดร้าน: <span class="font-semibold"> {{ siteInfo.site_open_time }} - {{ siteInfo.site_close_time }} </span></p>
        </div>

        <!-- Buttons Section -->
        <hr class="my-2">
        <div class="flex flex-wrap justify-center gap-4 mt-4 mx-4">
          <a href="tel:{{ formatPhoneNumber(contact) }}" class="flex items-center justify-center w-full sm:w-auto p-2 bg-gray-100 text-blue-500 border border-blue-500 hover:bg-gray-200 rounded-full shadow-lg text-sm sm:text-base">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 sm:w-6 sm:h-6 mr-2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 0 0 2.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 0 1-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 0 0-1.091-.852H4.5A2.25 2.25 0 0 0 2.25 4.5v2.25Z" />
            </svg>
            โทร: {{ siteInfo.site_contact }}
          </a>
          <button class="flex items-center justify-center w-full sm:w-auto px-6 py-2 bg-blue-500 text-white rounded-full hover:bg-blue-600 shadow-md"
          @click="siteInfo.openGoogleMap">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 sm:w-6 sm:h-6 mr-2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
            </svg>
            นำทาง
          </button>
        </div>
      </div>
    </div>

  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, watch } from "vue";
import { Loader } from "@googlemaps/js-api-loader";

export default defineComponent({
  name: "MapInfo",
  props: {
    modelValue: {
      type: String,
      required: false,
      default: null, // ค่าเริ่มต้น
    },
    branchInfoDisabled: {
      type: Boolean,
      required: true,
    },
    btnDisabled: {
      type: Boolean,
      required: true,
    },
    searchQuery: {
      type: String,
      required: false,
    },
    searchlocationName: {
      type: String,
      required: false,
    },
    initialPosition: {
      type: Object,
      required: false,
      default: () => ({ lat: 13.7563, lng: 100.5018 }), // ค่าเริ่มต้นเป็นกรุงเทพฯ
    },
    siteLocationInfoInfoDisabled: {
      type: Boolean,
      required: true,
      default: true
    },
    siteInfo: {
      type: Object,
      required: false,
    },
  },
  emits: ["update:address"],
  setup(props, { emit }) {
    const map = ref<google.maps.Map | null>(null);
    const selectedPosition = ref<object>({ lat: 13.7563, lng: 100.5018 }); // Default: Bangkok
    // const selectedPosition = ref(props.initialPosition || { lat: 13.7563, lng: 100.5018 }); // Default: Bangkok
    const address = ref<string | null>(null);
    const geocoder = ref<google.maps.Geocoder | null>(null);

    onMounted(() => {
      // ตรวจสอบว่า props.initialPosition มีค่าหรือไม่
      if (props.initialPosition && props.initialPosition.lat && props.initialPosition.lng) {
        // อัพเดตตำแหน่งเริ่มต้นจาก props ถ้ามีค่า
        selectedPosition.value = props.initialPosition;
      } else {
        // ถ้า props ไม่มีค่า ให้ใช้ค่าดีฟอลต์
        selectedPosition.value = { lat: 13.7563, lng: 100.5018 }; // ค่าเริ่มต้น
      }

      const loader = new Loader({
        apiKey: "AIzaSyDUeNLdnx0CqDtfCXRywGdcizCnBVCdwik", // ใช้ API Key ของคุณ
        version: "weekly",
        language: "th",
      });

      loader.load().then(() => {
        map.value = new google.maps.Map(
          document.getElementById("map") as HTMLElement,
          {
            center: selectedPosition.value,
            zoom: 15,
          }
        );

        geocoder.value = new google.maps.Geocoder();

        const marker = new google.maps.Marker({
          position: selectedPosition.value,
          map: map.value,
          draggable: true,
        });

        marker.addListener("dragend", (event) => {
          const newPosition = {
            lat: event.latLng?.lat() || 0,
            lng: event.latLng?.lng() || 0,
          };
          selectedPosition.value = newPosition;
          fetchAddress(newPosition);
        });

        // เมื่อ map ถูกโหลดแล้ว ต้องอัพเดตตำแหน่งของ marker
        watch(
          () => props.initialPosition,
          (newPosition) => {
            if (newPosition && newPosition.lat && newPosition.lng) {
              selectedPosition.value = newPosition;

              if (map.value) {
                map.value.setCenter(newPosition); // อัพเดตจุดศูนย์กลางของแผนที่
              }

              if (marker) {
                marker.setPosition(newPosition); // อัพเดตตำแหน่งของ marker
              }

              fetchAddress(newPosition); // ดึงที่อยู่ใหม่
            }
          },
          { immediate: true } // ใช้ `immediate` เพื่อเรียกครั้งแรกทันที
        );

        fetchAddress(selectedPosition.value);
      });
    });

    const fetchAddress = (position: { lat: number; lng: number }) => {
      if (!geocoder.value) return;

      geocoder.value.geocode(
        { location: position },
        (results: any, status: any) => {
          if (status === "OK" && results && results[0]) {
            address.value = results[0].formatted_address;
            emit("update:address", address.value); // ส่งค่า address ออกไป
          } else {
            console.error("Geocoder failed due to: " + status);
            address.value = null;
          }
        }
      );
    };

    const confirmLocation = () => {
      console.log("Selected Position:", selectedPosition.value);
      console.log("Address:", address.value);
    };

    return { confirmLocation, address };
  },
});
</script>

<style scoped>
.map-wrapper {
  position: relative;
  height: 100vh;
  overflow: hidden;
}

.map-container {
  width: 100%;
  height: 100%;
}

.branch-info-container {
  z-index: 10;
  max-width: 95%;
  width: auto;
  background-color: white;
}

.floating-button {
  position: absolute;
  bottom: 20px;
  /* left: 50%; */
  /* transform: translateX(-50%); */
  background-color: #0284c7;
  color: white;
  padding: 15px 20px;
  border: none;
  border-radius: 50px;
  box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.floating-button:hover {
  background-color: #0369a1;
  /* สี hover */
}
</style>
