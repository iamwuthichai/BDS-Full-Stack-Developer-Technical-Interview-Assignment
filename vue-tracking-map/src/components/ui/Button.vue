<template>
  <button :class="buttonClass">
    <slot>

    </slot>
  </button>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  name: 'Button',
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
