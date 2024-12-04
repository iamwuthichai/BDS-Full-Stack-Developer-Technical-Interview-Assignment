<template>
  <footer :class="footerClass">
    <slot>
      <p :class="footerTitleClass">{{ footerTitle }}</p>
    </slot>
  </footer>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";

export default defineComponent({
  name: 'FooterLayout',
  props: {
    footerTitle: {
      type: String,
      required: true
    },
    footerTitleClass: {
      type: String,
      required: true
    },
    footerClass: {
      type: String,
      required: true
    },
  }
});
</script>

<style scoped>

</style>
