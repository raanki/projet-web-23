<template>
  <span id="title">Create a User 👤</span>

  <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
    <VRow>
      <!-- Email -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.email" label="Email" placeholder="Enter email" />
      </VCol>

      <!-- First Name -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.firstname" label="First Name" placeholder="Enter first name" />
      </VCol>

      <!-- Last Name -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.lastname" label="Last Name" placeholder="Enter last name" />
      </VCol>

      <!-- Address -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.address" label="Address" placeholder="Enter address" />
      </VCol>

      <!-- Phone -->
      <VCol cols="12" md="6">
        <VTextField v-model="user.phone" label="Phone" placeholder="Enter phone number" />
      </VCol>

      <!-- Admin -->
      <VCol cols="12" md="6">
        <VSwitch v-model="user.isAdmin" label="Admin" @change="toggleStudentNumber"/>
      </VCol>

      <!-- Student Number (conditionally shown) -->
      <VCol cols="12" md="6" v-if="!user.isAdmin">
        <VTextField v-model="user.studentNumber" label="Student Number" placeholder="Enter student number" />
      </VCol>

      <!-- Avatar Image Upload -->
      <VCol cols="12">
        <input type="file" @change="onFileChange"  label="Avatar" />
      </VCol>
    </VRow>

    <VRow class="d-flex gap-4" style="margin-top: 40px !important;">
      <VBtn type="submit">Submit</VBtn>
      <VBtn type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import { ref } from 'vue';
import { VForm, VRow, VCol, VTextField, VSwitch, VBtn } from 'vuetify/components';

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

function submitForm() {
  console.log("User submitted with:", user.value);
}

function toggleStudentNumber() {
  if (user.value.isAdmin) {
    user.value.studentNumber = '';  // Clear student number if user is admin
  }
}

function onFileChange(e) {
  const files = e.target.files;
  if (files.length > 0) {
    const fileReader = new FileReader();

    // Object for storing file properties
    const fileInfo = {
      fileToken: "",
      fileName: "",
      fileType: "",
      lastModified: "",
      lastModifiedDate: "",
      size: "",
      type: "",
      webkitRelativePath: ""
    };

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
  color: black;
  font-weight: bold;
  margin-bottom: 20px !important;
}
</style>
