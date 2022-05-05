table 50173 TS_knjizenja
{
    Caption = 'TS_knjizenja';

    fields
    {
        field(1; vrnaloga; Code[10])
        {
            Caption = 'Šifra';
            NotBlank = true;
        }
        field(2; rb_st; Integer)
        {
            Caption = 'Opis';
        }
        field(3; D_C; Code[1])
        {
            Caption = 'D ili C';
        }
        field(4; opis; Text[100])
        {
        }
        field(5; "part"; Code[11])
        {
        }
        field(6; mb; Text[13])
        {
        }
        field(7; konto; Code[9])
        {


            TableRelation = if (D_C = const('C')) "G/L Account"."No." WHERE("Debit/Credit" = FILTER('0|1'))

            else
            if (D_C = const('D')) "G/L Account"."No." WHERE("Debit/Credit" = FILTER('0|2'));


        }
        field(8; sifra_val; Code[10])
        {
        }
        field(9; kurs; Code[10])
        {
        }
        field(10; iznos; Text[200])
        {
        }
        field(11; iznosKM; Text[200])
        {
        }
        field(12; org_jed; Code[10])
        {
        }
        field(13; org; Code[10])
        {
        }
        field(14; osnov; Code[10])
        {
        }
        field(15; idd; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; idd)
        {
        }
    }

    fieldgroups
    {
    }
}

