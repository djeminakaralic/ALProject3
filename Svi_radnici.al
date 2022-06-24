report 50095 "Svi radnici"
{
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Svi radnici.rdl';

    dataset
    {
        dataitem(DataItem1; "Employee Contract Ledger")
        {
            RequestFilterFields = "Starting Date";
            column(Adresa; CompInfo.Address)
            {
            }
            column(Grad; CompInfo.City)
            {
            }
            column(Slika; CompInfo.Picture)
            {
            }
            column(Tel; CompInfo."Phone No.")
            {
            }
            column(Kod; CompInfo."Country/Region Code")
            {
            }
            column(OJJ; "Department Code")
            {
            }
            column(Sluzba; "Department Category")
            {
            }
            column(Odjel; "Group Description")
            {
            }
            column(NazivRadnogMjesta; "Position Description")
            {
            }
            column(KrajDatum; FORMAT("Ending Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(Spol; Spol)
            {
            }
            column(Sektor; "Sector Description")
            {
            }
            column(Ime; Ime)
            {
            }
            column(Prezime; Prezime)
            {
            }
            column(EmploymentDate; EmploymentDate)
            {
            }
            column(Zvanje; Zvanje)
            {
            }
            column(Titula; Titula)
            {
            }
            column(EL; EL)
            {
                OptionCaption = ' ,I Stepen četri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
                OptionMembers = " ","I Stepen četri razreda osnovne","II Stepen - osnovna škola","III Stepen - SSS srednja škola","IV Stepen - SSS srednja škola","V Stepen - VKV - SSS srednja škola","VI Stepen - VS viša škola","VII Stepen - VSS visoka stručna sprema","VII-1 Stepen - Specijalista","VII-2 Stepen - Magistratura","VIII Stepen - Doktorat  ";
            }
            column(Pozicija; Pozicija)
            {
            }
            column(StartingDate; StartingDate)
            {
            }
            column(VrstaUgovora; VrstaUgovora)
            {
            }
            column(Koeficijent; Koeficijent)
            {
            }
            column(Select; Select)
            {
            }
            column(Sifra; "Employee No.")
            {
            }
            column(ImeRoditelja; ImeRoditelja)
            {
            }
            column(NazivOrgana; NazivOrgana)
            {
            }
            column(DatumRodjenja; DatumRodjenja)
            {
            }
            column(RazlogPrekida; "Grounds for Term. Description")
            {
            }

            trigger OnAfterGetRecord()
            begin

                CompInfo.RESET; //Pitati djeminu da li je ova linija potrebna, posto imamo GET--svejedeno
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
                NazivOrgana := CompInfo.Name;


                //Prikazi:=FALSE Entry No. je polje
                //Prikazi:=TRUE;

                DataItem1.CALCFIELDS(Gender);
                DataItem1.CALCFIELDS("Minimal Education Level");
                Spol := FORMAT(DataItem1.Gender);
                VrstaUgovora := DataItem1."Contract Type Name";
                //Koeficijent := DataItem1."Percentage of Variable";
                //STRUCNA SPREMA POZICIJE - NA BC TO RADI
                EL := DataItem1."Minimal Education Level";
                P.RESET;
                P.SETFILTER("Position ID", '%1', "Employee No.");
                IF P.FINDFIRST THEN BEGIN

                    Pozicija := FORMAT(P."Minimal Education Level");
                END ELSE BEGIN
                    Pozicija := '';
                END;
                //UZIMANJE IMENA I PREZIMENA RADNIKA, te imena jednog roditelja
                E.RESET;
                E.SETFILTER("No.", '%1', "Employee No.");
                E.SETFILTER(Active, '%1', TRUE);
                IF E.FINDFIRST THEN BEGIN
                    Ime := E."First Name";
                    Prezime := E."Last Name";
                    ImeRoditelja := E."Father Name";
                    Koeficijent := E."Work Experience Percentage";
                    EmploymentDate := FORMAT(E."Employment Date", 0, '<day,2>.<month,2>.<year4>.'); //ovo ne koristim kao employment date
                    DatumRodjenja := FORMAT(E."Birth Date", 0, '<day,2>.<month,2>.<year4>.');
                END ELSE BEGIN
                    Ime := '';
                    Prezime := '';
                    EmploymentDate := '';
                    ImeRoditelja := '';
                END;
                // TITULA I ZVANJE RADNIKA
                AE.RESET;
                AE.SETFILTER("Employee No.", '%1', "Employee No.");
                IF AE.FINDFIRST THEN BEGIN
                    Titula := FORMAT(AE."Education Level");
                    Zvanje := FORMAT(AE."Title Description");
                END ELSE BEGIN
                    Titula := '';
                    Zvanje := '';
                END;
                //WORK BOOKLET STARTING DATE ovo ok
                WB.RESET;
                WB.SETFILTER("Employee No.", '%1', "Employee No.");
                WB.SETFILTER("Current Company", '%1', TRUE);
                WB.SETFILTER("Starting Date", '<=%1', DataItem1."Starting Date");
                WB.SETCURRENTKEY("Starting Date");
                WB.ASCENDING;
                IF WB.FINDLAST THEN BEGIN
                    StartingDate := FORMAT(WB."Starting Date", 0, '<day,2>.<month,2>.<year4>.'); //ovo koristim kao employment date
                END ELSE BEGIN
                    StartingDate := '';
                END;
            end;

            trigger OnPreDataItem()
            begin

                IF Select = Select::"Otišli u zadanom intervalu" THEN
                    DataItem1.SETFILTER("Grounds for Term. Description", '<>%1', '');
                IF Select = Select::"Došli u zadanom intervalu" THEN
                    DataItem1.SETFILTER("Reason for Change", '%1', DataItem1."Reason for Change"::"New Contract");

                DataItem1.SETFILTER("Show Record", '%1', TRUE);
                DataItem1.SETCURRENTKEY("Starting Date");
                DataItem1.ASCENDING;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Select; Select)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ' ,Otišli u zadanom intervalu,Po stvarnoj stručnoj spremi,Spisak po radnim mjestima,Spisak po sektorima,Spisak po spolu,Spisak svih radnika,Došli u zadanom intervalu';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        ECL: Record "Employee Contract Ledger";
        EndingDate: Text;
        EmploymentDate: Text;
        E: Record "Employee";
        Titula: Text;
        AE: Record "Additional Education";
        Zvanje: Text;
        Odjel: Text;
        Sektor: Text;
        EL: Option;
        MinPos: Text;
        Position: Record "Position";
        VrstaUgovora: Text;
        Koeficijent: Decimal;
        Selected: Option ,"4","5","6","7","8","9","17";
        DepartmentCode: Text;
        Spol: Text;
        Sluzba: Text;
        Ime: Text;
        Prezime: Text;
        P: Record "Position";
        Pozicija: Text;
        WB: Record "Work booklet";
        StartingDate: Text;
        Select: Option ,"Otišli u zadanom intervalu","Po stvarnoj stručnoj spremi","Spisak po radnim mjestima","Spisak po sektorima","Spisak po spolu","Spisak svih radnika","Došli u zadanom intervalu";
        ImeRoditelja: Text;
        NazivOrgana: Text;
        DatumRodjenja: Text;
        Prikazi: Boolean;
}

