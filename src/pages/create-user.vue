<template>
  <span id="title">{{ formTitle }}</span>
  <VForm @submit.prevent="submitForm" ref="form" style="margin-top: 30px !important;">
    <VRow>
      <!-- Email -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.mail"
          label="Email"
          placeholder="Enter email"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Email is required']"
        />
      </VCol>
      <!-- First Name -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.firstname"
          label="First Name"
          placeholder="Enter first name"
          :disabled="isViewMode"
          :rules="[v => !!v || 'First Name is required']"
        />
      </VCol>
      <!-- Last Name -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.lastname"
          label="Last Name"
          placeholder="Enter last name"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Last Name is required']"
        />
      </VCol>
      <!-- Address -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.address"
          label="Address"
          placeholder="Enter address"
          :disabled="isViewMode"
        />
      </VCol>
      <!-- Phone -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.phone"
          label="Phone"
          placeholder="Enter phone number"
          :disabled="isViewMode"
        />
      </VCol>
      <!-- Job -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.job"
          label="Job"
          placeholder="Enter job"
          :disabled="isViewMode"
        />
      </VCol>
      <!-- Birth Date -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="user.birth_date"
          label="Birth Date"
          type="date"
          :disabled="isViewMode"
        />
      </VCol>
      <!-- Password (hidden for students) -->
      <VCol cols="12" md="6" v-if="!user.student_number">
        <VTextField
          v-model="user.password"
          label="Password"
          type="password"
          placeholder="Enter password"
          :disabled="isViewMode"
        />
      </VCol>
      <!-- Admin -->
      <VCol cols="12" md="6">
        <VSwitch
          v-model="user.isAdmin"
          label="Admin"
          @change="toggleStudentNumber"
          :disabled="isViewMode || isEditMode"
        />
      </VCol>
      <!-- Student Number (conditionally shown) -->
      <VCol cols="12" md="6" v-if="!user.isAdmin">
        <VTextField
          v-model="user.student_number"
          label="Student Number"
          placeholder="Enter student number"
          :disabled="isViewMode"
        />
      </VCol>
<!--       Avatar Image Upload -->
      <VCol cols="12">
        <input
          type="file"
          @change="onFileChange"
          label="Avatar"
          :disabled="isViewMode"
        />
      </VCol>
    </VRow>
    <VRow class="d-flex gap-4" style="margin-top: 40px !important;">
      <VBtn v-if="!isViewMode" type="submit">Submit</VBtn>
      <VBtn v-if="!isViewMode" type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { VForm, VRow, VCol, VTextField, VSwitch, VBtn } from 'vuetify/components';
import { defineProps } from 'vue';
import { API_URL } from '/src/env';

const props = defineProps({
  action: String,
  id: String,
});

const route = useRoute();
const router = useRouter();

const user = ref({
  mail: '',
  student_number: '',
  firstname: '',
  lastname: '',
  address: '',
  password: '',
  phone: '',
  job: '',
  birth_date: '',
  isAdmin: false,
  avatar: null,
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
    fetchUserById(userId).then(data => user.value = data);
  } else if (action === 'view') {
    formTitle.value = 'View User 👁️';
    isViewMode.value = true;
    fetchUserById(userId).then(data => user.value = data);
  } else {
    formTitle.value = 'Create User 🖥️';
  }
});

async function fetchUserById(id) {
  try {
    const response = await fetch(`${API_URL}api/user/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'fetch',
        mail: id,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching user:', error);
    return {
      mail: '',
      student_number: '',
      firstname: '',
      lastname: '',
      address: '',
      password: '',
      phone: '',
      job: '',
      birth_date: '',
      isAdmin: false,
      avatar: null,
    };
  }
}

async function updateUser(userData) {
  try {
    const response = await fetch(`${API_URL}api/user/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'update',
        ...userData,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error updating user:', error);
    return {
      error: 'Failed to update user',
    };
  }
}

async function createUser(userData) {
  try {
    const response = await fetch(`${API_URL}api/user/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'create',
        ...userData,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.text();
    try {
      console.log('data => ', data);
      const parsedData = JSON.parse(data);
      console.log('User created:', parsedData);
      router.push('/student');
    } catch (err) {
      console.error('Failed to parse JSON:', err, data);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

function submitForm() {
  if (isViewMode.value) return;

  let isValid = true;

  // Check each field for validity
  if (!user.value.mail) isValid = false;
  if (!user.value.firstname) isValid = false;
  if (!user.value.lastname) isValid = false;
  if (!user.value.address) isValid = false;
  if (!user.value.phone) isValid = false;
  if (!user.value.job) isValid = false;
  if (!user.value.birth_date) isValid = false;

  if (!isValid) return;

  if (props.action === 'edit') {
    updateUser(user.value).then(response => {
      if (!response.error) {
        router.push('/student');
      } else {
        console.error(response.error);
      }
    });
  } else {
    createUser(user.value);
  }
}

function toggleStudentNumber() {
  if (user.value.isAdmin) {
    user.value.student_number = '';
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

.required-field .v-label {
  color: red !important;
}

.required-field .v-input__control {
  border-color: red !important;
}
</style>
