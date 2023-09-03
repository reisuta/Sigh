<template>
 <div class="m-3 p-2 border">
  <div>test</div>
  <input class="mt-2 p-2 rounded border border-blue-300" type="text" v-model="text" placeholder="test" />
  <div>{{ text }}</div>
 </div>
</template>

<script setup lang="ts">
import { onBeforeMount, onMounted, onBeforeUpdate , onUpdated, onBeforeUnmount, onUnmounted, ref} from 'vue'
const text = ref('')

onBeforeMount(() => {
  console.log("on before mount")
})

onMounted(() => {
  console.log("on mount")
})

onBeforeUpdate(() => {
  console.log("on before update", text.value)
})

onUpdated(() => {
  console.log("on update", text.value)
})

onBeforeUnmount(() => {
  console.log("on before unmounted")
})

onUnmounted(() => {
  console.log("on unmounted")
})

console.log("on created")
</script>
