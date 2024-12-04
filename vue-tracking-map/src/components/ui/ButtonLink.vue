<template>
  <a href="tel:{{ formatPhoneNumber(siteInfo.site_tel) }}" :class="buttonClass">
    <slot>

    </slot>
  </a>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  name: 'ButtonLink',
  props: {
    title: {
      type: String,
      required: true
    },
    titleClass: {
      type: String,
      required: true
    },
    buttonClass: {
      type: String,
      required: true
    },
  }
});
</script>

<style scoped>

</style>
