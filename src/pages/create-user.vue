<template>
  <span id="title">{{ formTitle }}</span>

  <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
    <VRow>
      <!-- Email -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.email" label="Email" placeholder="Enter email" :disabled="isViewMode" />
      </VCol>

      <!-- First Name -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.firstname" label="First Name" placeholder="Enter first name" :disabled="isViewMode" />
      </VCol>

      <!-- Last Name -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.lastname" label="Last Name" placeholder="Enter last name" :disabled="isViewMode" />
      </VCol>

      <!-- Address -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.address" label="Address" placeholder="Enter address" :disabled="isViewMode" />
      </VCol>

      <!-- Phone -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.phone" label="Phone" placeholder="Enter phone number" :disabled="isViewMode" />
      </VCol>

      <!-- Admin -->
      <VCol cols="12" md="6">
        <VSwitch v-model="user.isAdmin" label="Admin" @change="toggleStudentNumber"
                 :disabled="isViewMode || isEditMode"/>
      </VCol>

      <!-- Student Number (conditionally shown) -->
      <VCol cols="12" md="6" v-if="!user.isAdmin">
        <VTextField v-model="user.studentNumber" label="Student Number" placeholder="Enter student number"
                    :disabled="isViewMode"/>
      </VCol>

      <!-- Avatar Image Upload -->
      <VCol cols="12">
        <input type="file" @change="onFileChange" label="Avatar" :disabled="isViewMode"/>
      </VCol>
    </VRow>

    <VRow class="d-flex gap-4" style="margin-top: 40px !important;">
      <VBtn v-if="!isViewMode" type="submit">Submit</VBtn>
      <VBtn v-if="!isViewMode" type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import {ref, onMounted} from 'vue';
import {VForm, VRow, VCol, VTextField, VSwitch, VBtn} from 'vuetify/components';
import {defineProps} from 'vue';

const props = defineProps({
  action: String,
  id: String,
});

const user = ref({
  email: '',
  firstname: '',
  lastname: '',
  address: '',
  phone: '',
  isAdmin: false,
  studentNumber: '',
  avatar: null
});

const formTitle = ref('');
const isViewMode = ref(false);
const isEditMode = ref(false);

onMounted(() => {
  const action = props.action;
  const userId = props.id;

  if (action === 'edit') {
    formTitle.value = 'Edit User 👤';
    isEditMode.value = true;
    fetchUser(userId);
  } else if (action === 'view') {
    formTitle.value = 'View User 👤';
    isViewMode.value = true;
    fetchUser(userId);
  } else {
    formTitle.value = 'Create User 👤';
  }
});

async function fetchUserById(id) {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve({
        email: 'sample@example.com',
        firstname: 'John',
        lastname: 'Doe',
        address: '123 Main St',
        phone: '123-456-7890',
        isAdmin: true,
        studentNumber: '12345',
        avatar: null
      });
    }, 1000);
  });
}

async function fetchUser(userId) {
  try {
    const userData = await fetchUserById(userId);
    Object.assign(user.value, userData);
  } catch (error) {
    console.error('Error fetching user:', error);
  }
}

async function submitForm() {
  console.log('User submitted with:', user.value);
}

function toggleStudentNumber() {
  if (user.value.isAdmin) {
    user.value.studentNumber = '';
  }
}

function onFileChange(e) {
  const files = e.target.files;
  if (files.length > 0) {
    const fileReader = new FileReader();

    fileReader.readAsDataURL(files[0]);
    fileReader.onload = () => {
      user.value.avatar = fileReader.result;
    };
  }
}
</script>

<style scoped>
#title {
  font-size: 2rem;
  font-style: italic;
  color: #6F72FF;
  font-weight: bold;
  margin-bottom: 20px !important;
}
</style>
