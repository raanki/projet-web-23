<script setup>
import CustomList from '@/components/custom-list.vue'
import { API_URL } from '/src/env'

const fields = [
  { key: 'name', label: 'Name' },
  { key: 'description', label: 'Description' },
  { key: 'purchase_date', label: 'Purchase Date' },
  { key: 'purchase_price', label: 'Price', formatter: value => `${value}€` },
  { key: 'supplier', label: 'Supplier' },
  { key: 'status', label: 'status' },
  { key: 'loan', label: 'Loan' },
  { key: 'availability', label: 'Availability' },
]


</script>

<template>

  <div class="row text-end" style="margin: 30px">
    <router-link to="/equipment/create" class="btn text-end add">Add an equipment ➕</router-link>
  </div>


  <div>
    <custom-list :items="equipments" :fields="fields" :title="'Equipement 🖥️'" :type="'equipment'"/>
  </div>
</template>

<script>

export default {
  data() {
    return {
      equipments: []
    }
  },
  methods: {
    fetchHelloWorld() {
      console.log(process.env);
      fetch(API_URL + 'api/equipment', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      })
        .then(response => response.json())
        .then(data => {
          this.equipments = data;
          console.log(this.equipments);
        })
        .catch(error => console.error('Error:', error));
    },
  },
  mounted() {
    this.fetchHelloWorld();
  }
}

</script>

<style>
.add.btn {
  color: #ffffff;
  background-color: #6F72FF;
  padding: 16px;
  border-radius: 15px;
  margin-bottom: 10px !important;
}
</style>
