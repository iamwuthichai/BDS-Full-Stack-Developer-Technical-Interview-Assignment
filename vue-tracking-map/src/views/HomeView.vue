<template>
  <MainLayout
  :hiddenHeader="hiddenHeader"
  :hiddenFooter="hiddenFooter"
  >

  </MainLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import MainLayout from '@/components/layouts/MainLayout.vue';

const hiddenHeader = ref(true);
const hiddenFooter = ref(true);

</script>

<style scoped>

</style>
