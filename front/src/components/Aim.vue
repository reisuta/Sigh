<template>
  <v-row>
    <v-row>
      <v-toolbar
        color="gray"
        dense
        outlined
        rounded
        class="mt-8">
        <v-toolbar-title
          class="mx-auto">
          目標一覧
        </v-toolbar-title>
      </v-toolbar>
    </v-row>
    <v-row>
      <!-- <v-col v-for="r in res[0]" :key="r.id"> -->
      <!--   <v-card -->
      <!--     :loading="loading" -->
      <!--     class="mx-auto my-12" -->
      <!--     max-width="374" -->
      <!--     @click="edit(r.id)" -->
      <!--   > -->
      <!--     <template slot="progress"> -->
      <!--       <v-progress-linear -->
      <!--         color="deep-purple" -->
      <!--         height="10" -->
      <!--         indeterminate -->
      <!--       ></v-progress-linear> -->
      <!--     </template> -->

      <!--     <div v-if="r.difficulty==='low'"> -->
      <!--       <v-img -->
      <!--         height="250" -->
      <!--         src="blue.jpeg" -->
      <!--       ></v-img> -->
      <!--     </div> -->

      <!--     <div v-if="r.difficulty==='middle'"> -->
      <!--       <v-img -->
      <!--         height="250" -->
      <!--         src="silver.jpeg" -->
      <!--       ></v-img> -->
      <!--     </div> -->

      <!--     <div v-if="r.difficulty==='high'"> -->
      <!--       <v-img -->
      <!--         height="250" -->
      <!--         src="orange.jpeg" -->
      <!--       ></v-img> -->
      <!--     </div> -->

      <!--     <v-card-title>{{ r.title }}</v-card-title> -->

      <!--     <v-card-text> -->
      <!--       <v-row -->
      <!--         align="center" -->
      <!--         class="mx-0" -->
      <!--       > -->
      <!--         <div class="ms-4"> -->
      <!--         </div> -->
      <!--       </v-row> -->

      <!--       <div class="my-4 text-subtitle-1"> -->
      <!--         得られるもの -->
      <!--       </div> -->

      <!--       <div>{{ r.advantage }}</div> -->
      <!--     </v-card-text> -->

      <!--     <v-divider class="mx-4"></v-divider> -->

      <!--     <v-card-title>{{ r.genre }}</v-card-title> -->

      <!--     <v-card-text> -->
      <!--       記載した月 : {{ r.started_at.slice(5, 7) }}月 -->
      <!--     </v-card-text> -->
      <!--   </v-card> -->
      <!-- </v-col> -->
    </v-row>
  </v-row>
</template>

<script setup lang="ts">
import { onBeforeMount, onMounted, onBeforeUpdate , onUpdated, onBeforeUnmount, onUnmounted, ref} from 'vue'
import axios from 'axios';
const text = ref('')

const res = []
onMounted(() => {
  axios.get('http://localhost:4000/api/aims')
  .then(function (response) {
    for (const l of response.data.records){
      res.push(l)
    }
  })
  console.log(res)
})
//export default {
//  data() {
//    return {
 //     item:{
  //      to: `${this.$route.params.id}`,
   //   },
    //  res:[]
    //}
//  },
 // created() {
  //  const res = []
//    axios.get('/api/aims')
 //   .then(function (response) {
  //    for (const l of response.data.records){
   //     console.log(l)
    //    res.push(l)
     // }
//    })
 //   this.res.push(res)
  //},
  //methods: {
    //edit(id) {
 //     console.log(this)
  //    console.log(id)
   //   this.$router.push(`/aims/${id}`)
//    },
 // }
//} 
</script>
