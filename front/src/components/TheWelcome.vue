<!-- 親 -->
<script setup lang="ts">
import { ref } from 'vue'
import Child from './Child.vue'
const greet = 'hello gwge'
const print = ():void => {
  console.log('emit')
}
</script>

<template>
  <Child
    :prop-a="greet"
    prop-b="399"
    @submit="print"
  />
</template>
