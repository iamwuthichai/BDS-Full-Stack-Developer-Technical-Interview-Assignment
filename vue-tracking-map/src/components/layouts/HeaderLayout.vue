<template>
  <header :class="`flex items-center justify-between p-4 md:p-6 bg-white shadow-md ${headerClass}`">
    <!-- Title -->
    <slot>
      <h1 :class="`flex-1 ${titleClass}`">
        {{ title }}
      </h1>
    </slot>

    <!-- Dropdown Menu -->
    <div class="relative">
      <!-- Mobile/Tablet Header Actions -->
      <button
        class="text-blue-500 hover:text-blue-700 focus:outline-none"
        @click="toggleDropdown">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>

      <!-- Dropdown Menu Content -->
      <ul v-if="isDropdownOpen" class="absolute right-0 mt-2 w-48 bg-white border rounded-lg shadow-lg z-10">
        <li class="hover:bg-gray-100 border-b last:border-0">
          <RouterLink :to="{ name: 'home' }">
            <a class="block px-4 py-2 text-gray-700 hover:text-blue-500">หน้าแรก</a>
          </RouterLink>
        </li>
        <li class="hover:bg-gray-100 border-b last:border-0">
          <RouterLink :to="{ name: 'find_branch' }">
            <a class="block px-4 py-2 text-gray-700 hover:text-blue-500">ค้นหาสาขา</a>
          </RouterLink>
        </li>
      </ul>
    </div>
  </header>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: 'HeaderLayout',
  props: {
    title: {
      type: String,
      required: true
    },
    titleClass: {
      type: String,
      default: ''
    },
    headerClass: {
      type: String,
      default: ''
    }
  },
  setup() {
    const isDropdownOpen = ref(false);

    const toggleDropdown = () => {
      isDropdownOpen.value = !isDropdownOpen.value;
    };

    return { isDropdownOpen, toggleDropdown };
  }
});
</script>

<style scoped>
/* Custom media queries can be added if needed */
</style>
