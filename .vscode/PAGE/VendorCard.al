pageextension 50178 VendorCard extends "Vendor Card"
{
    //ED

    layout
    {
        
        addafter(Name)
        {    
            field("Vendor Subgroup";"Vendor Subgroup")
            {
                ApplicationArea = all;
            }        
            field("Vendor Group";"Vendor Group")
            {
                ApplicationArea = all;
            }
            field("Vendor Class";"Vendor Class")
            {
                ApplicationArea = all;
            }
            field("Old No.";"Old No.")
            {
                ApplicationArea = all;
            }
            field("Industrial Classification";"Industrial Classification")
            {
                ApplicationArea = all;
            }
        }

        addafter("VAT Registration No.")
        {
            field("Registration No.";"Registration No.")
            {
                ApplicationArea = all;
            }
            field("Tax No.";"Tax No.")
            {
                ApplicationArea = all;
            }
        }

        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("Our Account No.")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        modify("Customized Calendar")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
    }
}