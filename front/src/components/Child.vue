<!-- 子 -->
<template>
  <div>
    <p>Prop A: {{ propA }}</p>
    <p>Prop B: {{ propB }}</p>
  </div>
  <button @click="submit">Submit</button>
</template>

<script setup lang="ts">
const props = defineProps({
  propA: {
    type: String,
    required: true
  },
  propB: {
    type: Number,
    default: 100
  }
})
const emit = defineEmits(["submit"])
const submit = () => {
  emit("submit")
}
</script>
