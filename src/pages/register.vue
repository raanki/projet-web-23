<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { API_URL } from '/src/env';

const router = useRouter();

const form = ref({
  mail: '',
  firstname: '',
  lastname: '',
  address: '',
  password: '',
  phone: '',
  job: '',
  birth_date: '',
});

const isPasswordVisible = ref(false);
const errorMessage = ref('');
const fieldErrors = ref({
  mail: '',
  firstname: '',
  lastname: '',
  address: '',
  password: '',
  phone: '',
  job: '',
  birth_date: '',
});

async function submitForm() {
  // Reset error messages
  errorMessage.value = '';
  fieldErrors.value = {
    mail: '',
    firstname: '',
    lastname: '',
    address: '',
    password: '',
    phone: '',
    job: '',
    birth_date: '',
  };

  // Validate form fields
  let hasErrors = false;
  for (const key in form.value) {
    if (!form.value[key]) {
      fieldErrors.value[key] = `Please complete the ${key} field.`;
      hasErrors = true;
    }
  }

  if (hasErrors) return;

  try {
    const response = await fetch(`${API_URL}api/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(form.value),
    });
    const result = await response.json();
    if (result.status === 'success') {
      router.push('/login');
    } else {
      errorMessage.value = result.message;
    }
  } catch (error) {
    errorMessage.value = 'An error occurred during registration.';
  }
}
</script>

<template>
  <div class="auth-wrapper d-flex align-center justify-center pa-4">
    <VCard class="auth-card pa-4 pt-7" max-width="448">
      <VCardItem class="justify-center">
        <template #prepend>
          <div class="d-flex">
            <div class="d-flex text-primary" v-html="logo"/>
          </div>
        </template>
        <VCardTitle class="text-2xl font-weight-bold">Register</VCardTitle>
      </VCardItem>

      <VCardText>
        <h5 class="text-h5 mb-1">Create a new admin account</h5>
      </VCardText>

      <VCardText v-if="errorMessage" class="text-red-500 mb-2">
        {{ errorMessage }}
      </VCardText>

      <VCardText>
        <VForm @submit.prevent="submitForm">
          <VRow>
            <!-- email -->
            <VCol cols="12">
              <VTextField
                v-model="form.mail"
                placeholder="johndoe@email.com"
                label="Email"
                type="email"
                :error-messages="fieldErrors.mail"
                :outlined="fieldErrors.mail ? 'true' : 'false'"
              />
            </VCol>

            <!-- firstname -->
            <VCol cols="12">
              <VTextField
                v-model="form.firstname"
                label="First Name"
                :error-messages="fieldErrors.firstname"
                :outlined="fieldErrors.firstname ? 'true' : 'false'"
              />
            </VCol>

            <!-- lastname -->
            <VCol cols="12">
              <VTextField
                v-model="form.lastname"
                label="Last Name"
                :error-messages="fieldErrors.lastname"
                :outlined="fieldErrors.lastname ? 'true' : 'false'"
              />
            </VCol>

            <!-- address -->
            <VCol cols="12">
              <VTextField
                v-model="form.address"
                label="Address"
                :error-messages="fieldErrors.address"
                :outlined="fieldErrors.address ? 'true' : 'false'"
              />
            </VCol>

            <!-- password -->
            <VCol cols="12">
              <VTextField
                v-model="form.password"
                label="Password"
                :type="isPasswordVisible ? 'text' : 'password'"
                :append-inner-icon="isPasswordVisible ? 'bx-hide' : 'bx-show'"
                @click:append-inner="isPasswordVisible = !isPasswordVisible"
                :error-messages="fieldErrors.password"
                :outlined="fieldErrors.password ? 'true' : 'false'"
              />
            </VCol>

            <!-- phone -->
            <VCol cols="12">
              <VTextField
                v-model="form.phone"
                label="Phone"
                :error-messages="fieldErrors.phone"
                :outlined="fieldErrors.phone ? 'true' : 'false'"
              />
            </VCol>

            <!-- job -->
            <VCol cols="12">
              <VTextField
                v-model="form.job"
                label="Job"
                :error-messages="fieldErrors.job"
                :outlined="fieldErrors.job ? 'true' : 'false'"
              />
            </VCol>

            <!-- birth_date -->
            <VCol cols="12">
              <VTextField
                v-model="form.birth_date"
                label="Birth Date"
                type="date"
                :error-messages="fieldErrors.birth_date"
                :outlined="fieldErrors.birth_date ? 'true' : 'false'"
              />
            </VCol>

            <!-- register button -->
            <VCol cols="12">
              <VBtn block type="submit">Register</VBtn>
            </VCol>

            <!-- already have account -->
            <VCol cols="12" class="text-center text-base">
              <span>Already have an account?</span>
              <RouterLink class="text-primary ms-2" to="/login">Sign in</RouterLink>
            </VCol>
          </VRow>
        </VForm>
      </VCardText>
    </VCard>
  </div>
</template>

<style lang="scss">
@use "@core/scss/template/pages/page-auth.scss";
</style>
