<template>
  <header :class="headerClass" class="flex items-center justify-between p-4 md:p-6 bg-white shadow-md">
    <!-- Logo / Home Button -->
    <!-- <RouterLink :to="{ name: "homeview" }">
      <button class="text-blue-500 hover:text-blue-700">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
        </svg>
      </button>
    </RouterLink> -->

    <!-- Title -->
    <slot>
      <h1 :class="titleClass" class=" flex-1">
        {{ title }}
      </h1>
    </slot>

    <!-- Mobile/Tablet Header Actions (Optional) -->
    <div class="flex md:hidden">
      <!-- Additional mobile actions like menu icon can go here -->
      <button class="text-blue-500 hover:text-blue-700">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>
    </div>
  </header>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";
import { RouterLink, RouterView } from "vue-router";

export default defineComponent({
  name: 'HeaderLayout',
  props: {
    title: {
      type: String,
      required: true
    },
    titleClass: {
      type: String,
      required: true
    },
    headerClass: {
      type: String,
      required: true
    },
  }
});
</script>

<style scoped>
/* Optional: Add some custom styles for header */
@media (max-width: 640px) {
  header {
    padding: 12px;
  }
  h1 {
    font-size: 1.25rem;
  }
}
</style>
