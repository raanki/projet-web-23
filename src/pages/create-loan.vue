<template>
  <span id="title">{{ formTitle }}</span>
  <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
    <VRow>
      <!-- Nom de l'emprunteur -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.borrowerName" :label="labels.borrowerName" placeholder="Enter borrower's name" :disabled="isViewMode" />
      </VCol>
      <!-- Description du prêt -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.description" :label="labels.description" placeholder="Enter description" type="textarea" :disabled="isViewMode" />
      </VCol>
      <!-- Date de début -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.startDate" :label="labels.startDate" type="date" :disabled="isViewMode" />
      </VCol>
      <!-- Date de fin -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.endDate" :label="labels.endDate" type="date" :disabled="isViewMode" />
      </VCol>
      <!-- Montant -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.amount" :label="labels.amount" prefix="$" type="number" :disabled="isViewMode" />
      </VCol>
    </VRow>
    <VRow class="d-flex gap-4" style="margin-top: 40px !important;">
      <VBtn v-if="!isViewMode" type="submit">Submit</VBtn>
      <VBtn v-if="!isViewMode" type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { VForm, VRow, VCol, VTextField, VBtn } from 'vuetify/components'
import { defineProps } from 'vue'

const props = defineProps({
  action: String,
  id: String,
})

const route = useRoute()
const router = useRouter()

const loan = ref({
  borrowerName: '',
  description: '',
  startDate: '',
  endDate: '',
  amount: ''
})

const labels = {
  borrowerName: 'Borrower Name',
  description: 'Description',
  startDate: 'Start Date',
  endDate: 'End Date',
  amount: 'Amount'
}

const formTitle = ref('')
const isViewMode = ref(false)

onMounted(() => {
  const action = props.action
  const loanId = props.id

  if (action === 'edit') {
    formTitle.value = 'Edit Loan ✏️'
    fetchLoanById(loanId).then(data => loan.value = data)
  } else if (action === 'view') {
    formTitle.value = 'View Loan 👁️'
    isViewMode.value = true
    fetchLoanById(loanId).then(data => loan.value = data)
  } else {
    formTitle.value = 'Create a Loan 🤝'
  }
})

function fetchLoanById(id) {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve({
        borrowerName: 'Sample Borrower',
        description: 'Sample Description',
        startDate: '2023-01-01',
        endDate: '2023-12-31',
        amount: 1000
      })
    }, 1000)
  })
}

function submitForm() {
  if (isViewMode.value) return
  // Logique de soumission de formulaire
  console.log("Loan submitted with:", loan.value)
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
