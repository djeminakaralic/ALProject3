tableextension 50119 VendorExtented extends Vendor
{
    //ED

    fields
    {
        field(50020; "Registration No."; Text[20])
        {
        }
        field(50021; "Vendor Class"; Text[100])
        {
        }
        field(50022; "Vendor Group"; Text[100])
        {
        }
        field(50023; "Vendor Subgroup"; Text[100])
        {
        }
    }

    var
        myInt: Integer;
}