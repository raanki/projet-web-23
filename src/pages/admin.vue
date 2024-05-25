<script setup>
import CustomList from '@/components/custom-list.vue'

const admins = [
  {
    mail: 'hannah@example.com',
    firstname: 'Hannah',
    lastname: 'Montana',
    address: '100 Mountain Drive, Denver, CO',
    phone: '555-1000',
  },
  {
    mail: 'luke@example.com',
    firstname: 'Luke',
    lastname: 'Skywalker',
    address: '200 Star Park, San Diego, CA',
    phone: '555-2000',
  },
  {
    mail: 'diana@example.com',
    firstname: 'Diana',
    lastname: 'Prince',
    address: '300 Palace Lane, Metropolis, IL',
    phone: '555-3000',
  },
  {
    mail: 'bruce@example.com',
    firstname: 'Bruce',
    lastname: 'Wayne',
    address: '400 Bat Cave, Gotham, NJ',
    phone: '555-4000',
  },
  {
    mail: 'clark@example.com',
    firstname: 'Clark',
    lastname: 'Kent',
    address: '500 Farm Avenue, Smallville, KS',
    phone: '555-5000',
  }
];

const fields = [
  { model: '', key: 'mail', label: 'Mail', },
  { model: '', key: 'firstname', label: 'Firstname'},
  { model: '', key: 'lastname', label: 'Lastname' },
  { model: '', key: 'address', label: 'Address', },
  { model: '', key: 'phone', label: 'Phone', },
];
</script>

<template>


  <div class="row text-end" style="margin: 30px">
    <router-link to="/loan/create" class="btn text-end add">Add an admin</router-link>
  </div>


  <div class="row">
    <custom-list :items="admins" :fields="fields" :title="'Admin'" />
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
