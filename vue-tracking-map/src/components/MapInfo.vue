<template>
  <div class="map-wrapper">
    <div id="map" class="map-container"></div>

     <!-- Branch Info -->
    <div :hidden="branchInfoDisabled" class="branch-info-container fixed bottom-5 left-1/2 transform -translate-x-1/2 bg-gray-100 text-black p-4 rounded-md shadow-lg text-lg cursor-pointer transition-all hover:bg-gray-200">
      <div class="flex items-center mb-2">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
            </svg>
        <p class="ml-2 text-gray-700">
           <span class="font-semibold">{{ searchQuery || address }}</span>
        </p>
      </div>

      <RouterLink :to="{ name: 'find_branch', query: { sitename: searchlocationName} }">
        <button
          class="my-2 min-w-full bottom-5 left-1/2 transform  bg-blue-500 text-white p-4 rounded-full shadow-lg text-lg cursor-pointer transition-all hover:bg-blue-600"
          @click="confirmLocation" :hidden="btnDisabled">
          ยืนยันตำแหน่ง
        </button>
      </RouterLink>
    </div>

  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";
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
    }
  },
  emits: ["update:address"],
  setup(props, { emit }) {
    const map = ref<google.maps.Map | null>(null);
    const selectedPosition = ref({ lat: 13.7563, lng: 100.5018 }); // Default: Bangkok
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
        // apiKey: "AIzaSyDUeNLdnx0CqDtfCXRywGdcizCnBVCdwik", // ใช้ API Key ของคุณ
        apiKey: "YOUR_KEY", // ใช้ API Key ของคุณ
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
        // watch(selectedPosition, (newPosition) => {
        //   if (marker) {
        //     marker.setPosition(newPosition); // อัพเดตตำแหน่งของ marker ทุกครั้งที่ selectedPosition เปลี่ยน
        //     map.value?.setCenter(newPosition); // อัพเดตจุดศูนย์กลางของแผนที่
        //   }
        // });

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
  background-color: #0369a1; /* สี hover */
}
</style>
