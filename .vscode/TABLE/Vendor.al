tableextension 50119 VendorExtented extends Vendor
{
    //ED

    fields
    {
        field(50020; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(50021; "Vendor Class"; Text[100])
        {
            Caption = 'Vendor Class';
        }
        field(50022; "Vendor Group"; Text[100])
        {
            Caption = 'Vendor Group';
        }
        field(50023; "Vendor Subgroup"; Text[100])
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
    }

    var
        myInt: Integer;
}