document.addEventListener("DOMContentLoaded", function () {
    const memberSelect = document.getElementById("member_select");
  
    if (memberSelect) {
      memberSelect.addEventListener("change", function () {
        const memberId = this.value;
        if (memberId) {
          fetch(`/members/${memberId}/details`)
            .then(response => response.json())
            .then(data => {
              document.getElementById("member_surname").value = data.surname || "";
              document.getElementById("member_given_name").value = data.given_name || "";
              document.getElementById("member_other_name").value = data.other_name || "";
              document.getElementById("member_full_name").value = data.full_name || "";
              document.getElementById("member_dob").value = data.date_of_birth || "";
              document.getElementById("member_phone").value = data.phone || "";
              document.getElementById("member_id_number").value = data.id_number || "";
              document.getElementById("member_membership_type").value = data.membership_type || "";
              document.getElementById("member_marital_status").value = data.marital_status || "";
              document.getElementById("member_physical_address").value = data.physical_address || "";
              document.getElementById("member_gender").value = data.gender || "";
              document.getElementById("member_identification_type").value = data.identification_type || "";
  
              document.getElementById("mother_name").value = data.mother_name || "";
              document.getElementById("mother_nationality").value = data.mother_nationality || "";
              document.getElementById("father_name").value = data.father_name || "";
              document.getElementById("father_nationality").value = data.father_nationality || "";
  
              document.getElementById("kin_surname").value = data.kin_surname || "";
              document.getElementById("kin_given_name").value = data.kin_given_name || "";
              document.getElementById("kin_other_name").value = data.kin_other_name || "";
              document.getElementById("kin_date_of_birth").value = data.kin_date_of_birth || "";
              document.getElementById("kin_gender").value = data.kin_gender || "";
              document.getElementById("kin_relationship").value = data.kin_relationship || "";
              document.getElementById("kin_phone").value = data.kin_phone || "";
              document.getElementById("kin_address").value = data.kin_address || "";
  
              document.getElementById("declaration_name").value = data.declaration_name || "";
              document.getElementById("declaration_date").value = data.declaration_date || "";
  
              document.getElementById("account_number").value = data.account_number || "";
              document.getElementById("target_amount").value = data.target_amount || "";
              document.getElementById("total_contributed").value = data.total_contributed || "";
              document.getElementById("savings_progress").value = data.savings_progress || "0";
            })
            .catch(error => console.error("Error fetching member details:", error));
        }
      });
    }
  });
  