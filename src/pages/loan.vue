<script setup>
import CustomList from '@/components/custom-list.vue'

const loans = [
  {
    id: '123',
    start_date: '2023-01-01',
    expect_end_date: '2023-12-31',
    commentary: 'Long term loan for project X',
    status: 'Active'
  },
  {
    id: '124',
    start_date: '2023-02-15',
    expect_end_date: '2023-08-15',
    commentary: 'Short term loan for project Y',
    status: 'Completed'
  },
  {
    id: '125',
    start_date: '2023-03-20',
    expect_end_date: '2023-09-20',
    commentary: 'Medium term loan for project Z',
    status: 'In Progress'
  }
];


const fields = [
  { model: '', key: 'id', label: 'Id', placeholder: 'Enter ID', type: 'text' },
  { model: '', key: 'start_date', label: 'Start Date', placeholder: 'YYYY-MM-DD', type: 'date' },
  { model: '', key: 'expect_end_date', label: 'End Date', placeholder: 'YYYY-MM-DD', type: 'date' },
  { model: '', key: 'commentary', label: 'Commentary', placeholder: 'Enter commentary', type: 'textarea' },
  { model: '', key: 'status', label: 'Status', placeholder: 'Select status', type: 'select', options: ['Active', 'Completed', 'In Progress'] }
];
</script>

<template>


    <div class="row text-end" style="margin: 30px">
      <router-link to="/loan/create" class="btn text-end add">Add a loan ➕</router-link>
    </div>


    <div class="row">
      <custom-list :items="loans" :fields="fields" :title="'Loan 🤝'" />
    </div>

</template>


<style>
.add.btn {
  color: #ffffff;
  background-color: #6F72FF;
  padding: 16px;
  border-radius: 15px;
  margin-bottom: 10px !important;
}
</style>
