import { createClient } from '@supabase/supabase-js';

// Replace with your Supabase URL and anon key
const supabaseUrl = 'https://sksyzcsstxtirchbuulk.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNrc3l6Y3NzdHh0aXJjaGJ1dWxrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ5MzE5NzMsImV4cCI6MjA1MDUwNzk3M30.0xMUC8m_vWp-NYTFoIKSkZhFlmafKAuwkuwRLMgXjzo';

const supabase = createClient(supabaseUrl, supabaseKey);

export async function fetchFarmersDetails() {
  const { data, error } = await supabase
    .from('Farmers_detail_Agri_Dashboard_GlobalGreen')
    .select('*');

  if (error) {
    console.error('Error fetching Farmers details:', error);
    return [];
  }
  return data;
}


export default supabase;
