<script setup>
import { ref } from 'vue';
import CustomList from '@/components/custom-list.vue';
import { API_URL } from '/src/env';

const students = ref([]);

const fields = [
  { model: '', key: 'mail', label: 'Mail' },
  { model: '', key: 'student_number', label: 'Student Number' },
  { model: '', key: 'firstname', label: 'Firstname' },
  { model: '', key: 'lastname', label: 'Lastname' },
  { model: '', key: 'address', label: 'Address' },
  { model: '', key: 'phone', label: 'Phone' }
];

async function fetchStudents() {
  try {
    const response = await fetch(API_URL + 'api/user/?role=student');
    if (response.ok) {
      students.value = await response.json();
    } else {
      console.error('Failed to fetch students');
    }
  } catch (error) {
    console.error('Error fetching students:', error);
  }
}

fetchStudents();
</script>

<template>
  <div class="row text-end" style="margin: 30px">
    <router-link to="/user/create" class="btn text-end add">Add a student ➕</router-link>
  </div>

  <div class="row">
    <custom-list :items="students" :fields="fields" :title="'Student 👨‍🎓'" :type="'user'"/>
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
