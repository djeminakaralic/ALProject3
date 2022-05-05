tableextension 50095 FixedAsset extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here
        field(50014; "Veichle Weight"; Decimal)
        {
            Caption = 'Veichle Weight';
            Description = 'NK01';
        }
        field(50015; "Veichle Load"; Decimal)
        {
            Caption = 'Veichle Load';
            Description = 'NK01';
        }
        field(50006; "Veichle Type"; Option)
        {
            Caption = 'Veichle Type';
            Description = 'NK01';
            OptionCaption = ' ,Putničko vozilo,Teretno vozilo,Kombi,Dostavno vozilo,Sanitetsko vozilo,Terensko vozilo,Specijalno teretno vozilo,Specijalno teretno vozilo - hladnjača,Specijalno policijsko vozilo,Kombinovano,Specijalno vozilo';
            OptionMembers = " ",Passenger,Truck,Van,Delivery,Sanitet,Teren,Special,"Special-fridge","Special-police-veichle",Combined,"Special Veichle";
        }
        field(50009; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            Description = 'NK01';
        }
        field(50007; "Veichle Brand"; Option)
        {
            Caption = 'Veichle Model';
            Description = 'NK01';
            OptionCaption = ' ,VW,Seat,Audi,Renault,Toyota,Opel,Mercedes,Mazda,Fiat,Ford';
            OptionMembers = " ",VW,Seat,Audi,Renault,Toyota,Opel,Mercedes;
        }

    }

    var
        myInt: Integer;
}