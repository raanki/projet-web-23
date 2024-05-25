<script setup>
import CustomList from '@/components/custom-list.vue'

const equipment = [
  {
    name: 'Laptop HP ProBook',
    description: 'Laptop professionnel 15 pouces',
    purchaseDate: '2023-01-15',
    price: 1200,
    supplier: 'HP Store',
    loan: 'No loans currently',
    availability: 'Available',
  },
  {
    name: 'Projector Sony XZ2',
    description: 'Full HD projector 1080p',
    purchaseDate: '2023-02-20',
    price: 890,
    supplier: 'Sony Outlet',
    loan: 'Loaned to Class A',
    availability: 'Unavailable',
  },
  {
    name: 'Laptop HP ProBook',
    description: 'Laptop professionnel 15 pouces',
    purchaseDate: '2023-01-15',
    price: 1200,
    supplier: 'HP Store',
    loan: 'No loans currently',
    availability: 'Available',
  },
  {
    name: 'Projector Sony XZ2',
    description: 'Full HD projector 1080p',
    purchaseDate: '2023-02-20',
    price: 890,
    supplier: 'Sony Outlet',
    loan: 'Loaned to Class A',
    availability: 'Unavailable',
  },
  {
    name: 'Laptop HP ProBook',
    description: 'Laptop professionnel 15 pouces',
    purchaseDate: '2023-01-15',
    price: 1200,
    supplier: 'HP Store',
    loan: 'No loans currently',
    availability: 'Available',
  },
  {
    name: 'Projector Sony XZ2',
    description: 'Full HD projector 1080p',
    purchaseDate: '2023-02-20',
    price: 890,
    supplier: 'Sony Outlet',
    loan: 'Loaned to Class A',
    availability: 'Unavailable',
  },
]

const fields = [
  { key: 'name', label: 'Name' },
  { key: 'description', label: 'Description' },
  { key: 'purchaseDate', label: 'Purchase Date' },
  { key: 'price', label: 'Price', formatter: value => `${value}€` },
  { key: 'supplier', label: 'Supplier' },
  { key: 'loan', label: 'Loan' },
  { key: 'availability', label: 'Availability' },
]
</script>

<template>
  <div>
    <custom-list :items="equipment" :fields="fields" :title="'Equipement'" />
  </div>
</template>
