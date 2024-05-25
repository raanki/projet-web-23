<template>

  <VForm @submit.prevent="submitForm">
    <VRow>
      <!-- Champs de dates et commentaire -->
      <VCol cols="12" md="6">
        <VTextField v-model="startDate" label="Start Date" type="date" />
      </VCol>
      <VCol cols="12" md="6">
        <VTextField v-model="expectedEndDate" label="Expected End Date" type="date" />
      </VCol>
      <VCol cols="12">
        <VTextField v-model="commentary" label="Commentary" placeholder="Add your comments here" type="textarea" />
      </VCol>
    </VRow>

    <VRow>


        <!-- Sélection d'équipement -->
        <VCol cols="12" md="6">
          <VSelect
            label="Select Equipment"
            :items="['Laptop', 'Printer', 'Monitor', 'Mouse', 'Keyboard', 'Webcam']"
          />
        </VCol>

        <!-- Sélection ou création d'utilisateur -->
        <VCol cols="12" md="6">
          <VSelect
            label="Select User"
            :items="['John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown', 'Carol White', 'Dave Wilson']"
          />
        </VCol>



      <!-- Bouton pour créer un nouvel utilisateur -->
      <VCol cols="12" class="text-end">
        <VBtn @click="showUserForm = true">New User</VBtn>
      </VCol>

      <!-- Champs de création de l'utilisateur, affichés conditionnellement -->
      <template v-if="showUserForm">
        <VCol cols="12" md="6">
          <VTextField v-model="newUser.firstName" label="First Name" placeholder="John" />
        </VCol>
        <VCol cols="12" md="6">
          <VTextField v-model="newUser.lastName" label="Last Name" placeholder="Doe" />
        </VCol>
        <VCol cols="12" md="6">
          <VTextField v-model="newUser.email" label="Email" placeholder="johndoe@email.com" />
        </VCol>
        <VCol cols="12" md="6">
          <VTextField v-model="newUser.studentNumber" label="Student Number" placeholder="123456" />
        </VCol>
        <VCol cols="12">
          <VTextField v-model="newUser.address" label="Address" placeholder="123 Main St" />
        </VCol>
      </template>
    </VRow>

    <VRow class="d-flex gap-4">
      <VBtn type="submit">Submit</VBtn>
      <VBtn type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import { ref } from 'vue'
import { VForm, VRow, VCol, VTextField, VSelect, VBtn } from 'vuetify/components'


const startDate = ref('')
const expectedEndDate = ref('')
const commentary = ref('')
const selectedEquipment = ref(null)
const selectedUser = ref(null)

const newUser = ref({
  firstName: '',
  lastName: '',
  email: '',
  studentNumber: '',
  address: ''
})
const showUserForm = ref(false)

function submitForm() {
  // Logique de soumission de formulaire
  console.log("Form submitted with:", { startDate, expectedEndDate, commentary, selectedEquipment, selectedUser, newUser })
}
</script>

<style scoped>
#title {
  font-size: 3rem;
  color: black;
  font-weight: bold;
  margin-bottom: 10px;
}

</style>
