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
  { key: 'id', label: 'Id' },
  { key: 'start_date', label: 'Start' },
  { key: 'expect_end_date', label: 'End' },
  { key: 'commentary', label: 'Commentary' },
  { key: 'status', label: 'Status' },
];
</script>

<template>
  <div class="container">

    <div class="row  text-end" style="margin: 30px">
        <a href="" class="btn text-end add">Add a loan</a>
    </div>

    <div class="row">
      <custom-list :items="loans" :fields="fields" :title="'Loan'" />
    </div>

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
