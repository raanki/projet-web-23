<script setup>
import CustomList from '@/components/custom-list.vue'

const students = [
  {
    mail: 'alice@example.com',
    student_number: 'S1001',
    firstname: 'Alice',
    lastname: 'Johnson',
    address: '123 Cherry Lane, New York, NY',
    phone: '555-0100',
  },
  {
    mail: 'bob@example.com',
    student_number: 'S1002',
    firstname: 'Bob',
    lastname: 'Smith',
    address: '456 Maple Street, San Francisco, CA',
    phone: '555-0200',
  },
  {
    mail: 'carol@example.com',
    student_number: 'S1003',
    firstname: 'Carol',
    lastname: 'White',
    address: '789 Oak Avenue, Chicago, IL',
    phone: '555-0300',
  },
  {
    mail: 'dave@example.com',
    student_number: 'S1004',
    firstname: 'Dave',
    lastname: 'Brown',
    address: '321 Pine Road, Miami, FL',
    phone: '555-0400',
  },
  {
    mail: 'eva@example.com',
    student_number: 'S1005',
    firstname: 'Eva',
    lastname: 'Davis',
    address: '654 Elm Street, Seattle, WA',
    phone: '555-0500',
  }
];


const fields = [
  { model: '', key: 'mail', label: 'Mail', },
  { model: '', key: 'student_number', label: 'Student Number'},
  { model: '', key: 'firstname', label: 'Firstname'},
  { model: '', key: 'lastname', label: 'Lastname' },
  { model: '', key: 'address', label: 'Address', },
  { model: '', key: 'phone', label: 'Phone', },
];
</script>

<template>


  <div class="row text-end" style="margin: 30px">
    <router-link to="/user/create" class="btn text-end add">Add a student ➕</router-link>
  </div>


  <div class="row">
    <custom-list :items="students" :fields="fields" :title="'Student 👨‍🎓'" />
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
