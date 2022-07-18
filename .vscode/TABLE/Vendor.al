tableextension 50119 VendorExtented extends Vendor
{
    //ED

    fields
    {
        field(50020; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(50021; "Vendor Class"; Code[50])
        {
            Caption = 'Vendor Class';
        }
        field(50022; "Vendor Group"; Code[50])
        {
            Caption = 'Vendor Group';
        }
        field(50023; "Vendor Subgroup"; Code[50])
        {
            Caption = 'Vendor Subgroup';
        }
        field(50024; "Industrial Classification"; Text[8])
        {
            Caption = 'Industrial Classification';
        }
         field(50025; "Tax No."; Text[20])
        {
            Caption = 'Tax No.';
        }
        field(50026; "Old No."; Integer)
        {
            Caption = 'Old No.';
        }

    }

    var
        myInt: Integer;
}