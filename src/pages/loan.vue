<script setup>
import CustomList from '@/components/custom-list.vue'
import { API_URL } from '/src/env'

const fields = [
  {model: '', key: 'loan_id', label: 'Id', placeholder: 'Enter ID', type: 'text'},
  {model: '', key: 'start_date', label: 'Start Date', placeholder: 'YYYY-MM-DD', type: 'date'},
  {model: '', key: 'expect_end_date', label: 'End Date', placeholder: 'YYYY-MM-DD', type: 'date'},
  {model: '', key: 'commentary', label: 'Commentary', placeholder: 'Enter commentary', type: 'textarea'},
  {model: '', key: 'mail', label: 'Student Mail', placeholder: 'Enter mail', type: 'textarea'},
  {model: '', key: 'material_id', label: 'Equipment ID', placeholder: 'Enter equipment id', type: 'textarea'},
]

</script>

<template>

  <div class="row text-end" style="margin: 30px">
    <router-link to="/loan/create" class="btn text-end add">Add a loan ➕</router-link>
  </div>

  <div class="row">
    <custom-list :items="loans" :fields="fields" :title="'Loan 🤝'" :type="'loan'"/>
  </div>

</template>

<script>
import { API_URL } from '/src/env'
export default {
  data() {
    return {
      loans: []
    }
  },
  methods: {
    fetchLoans() {
      console.log(process.env);
      fetch(API_URL + 'api/loan', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      })
        .then(response => response.json())
        .then(data => {
          this.loans = data.map(item => {
            return {
              ...item,
              id: item.loan_id
            }
          });
          console.log(this.loans);
        })
        .catch(error => console.error('Error:', error));
    },
  },
  mounted() {
    this.fetchLoans();
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
