<template>
  <div class="grid grid-rows-layout min-h-screen bg-gray-200">
    <!-- Header -->
    <!-- Title to component -->
    <HeaderLayout
    :title="headerTitle"
    :titleClass="titleClass"
    :headerClass="headerClass"
    />

    <!-- Main Content Area -->
    <main class="p-6">
      <slot></slot>
    </main>

    <!-- Footer -->
    <!-- Footer to component -->
    <FooterLayout hidden
    :footerTitle="footerTitle"
    :footerTitleClass="footerTitleClass"
    :footerClass="footerClass"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import HeaderLayout from './HeaderLayout.vue';
import FooterLayout from './FooterLayout.vue';

export default defineComponent({
  name: 'MainLayout',
  components: {
    HeaderLayout,
    FooterLayout
  },
  props: {
    headerTitle: {
      type: String,
      required: false,
      default: "", // ค่าเริ่มต้น
    },
  },
  data() {
    return {
      title: "เลือกที่อยู่ส่งด่วน",
      titleClass: "text-center text-base font-bold",
      headerClass: "bg-gray-100 text-sky-500 p-4",
      footerTitle: "2024 BDS - Tracking Map. All Rights Reserved.",
      footerTitleClass: "",
      footerClass: "bg-gray-800 text-white text-center p-4 shadow-md",
    }
  }
});
</script>

<style >
/* ใช้ grid ในการจัดตำแหน่ง */
.grid-rows-layout {
  grid-template-rows: auto 1fr auto;
}
</style>
