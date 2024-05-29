<template>
  <span id="title">{{ formTitle }}</span>
  <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
    <VRow>
      <!-- Adresse email -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.mail" :label="labels.mail" placeholder="Enter borrower's email" :disabled="isViewMode" />
      </VCol>
      <!-- Date de début -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.start_date" :label="labels.startDate" type="date" :disabled="isViewMode" />
      </VCol>
      <!-- Date de fin prévue -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.expect_end_date" :label="labels.expectEndDate" type="date" :disabled="isViewMode" />
      </VCol>
      <!-- Date de fin réelle -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.actual_end_date" :label="labels.actualEndDate" type="date" :disabled="isViewMode" />
      </VCol>
      <!-- Commentaire -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.commentary" :label="labels.commentary" placeholder="Enter commentary" type="textarea" :disabled="isViewMode" />
      </VCol>
      <!-- Identifiant du matériel -->
      <VCol cols="12" md="6">
        <VTextField v-model="loan.material_id" :label="labels.materialId" type="number" :disabled="isViewMode" />
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
import { API_URL } from '/src/env'

const props = defineProps({
  action: String,
  id: String,
})

const route = useRoute()
const router = useRouter()

const loan = ref({
  mail: '',
  loan_id: '',
  start_date: '',
  expect_end_date: '',
  actual_end_date: '',
  commentary: '',
  material_id: ''
})

const labels = {
  mail: 'Email',
  startDate: 'Start Date',
  expectEndDate: 'Expected End Date',
  actualEndDate: 'Actual End Date',
  commentary: 'Commentary',
  materialId: 'Material ID'
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

async function fetchLoanById(id) {
  try {
    const response = await fetch(`${API_URL}api/loan`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'fetch',
        id: id,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching loan:', error);
    return {
      mail: '',
      loan_id: '',
      start_date: '',
      expect_end_date: '',
      actual_end_date: '',
      commentary: '',
      material_id: ''
    };
  }
}

function createLoan(loanData) {
  fetch(`${API_URL}api/loan`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      action: 'create',
      ...loanData,
    }),
  })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok ' + response.statusText);
      }
      return response.text();
    })
    .then(text => {
      try {
        const data = JSON.parse(text);
        console.log('Loan created:', data);
        router.push('/loan');
      } catch (err) {
        console.error('Failed to parse JSON:', err, text);
      }
    })
    .catch(error => console.error('Error:', error));
}

function submitForm() {
  if (isViewMode.value) return;
  createLoan(loan.value);
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
