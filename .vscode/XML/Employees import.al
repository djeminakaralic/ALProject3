xmlport 50004 "Employees Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Employees Import';




    schema
    {
        textelement(Root)
        {
            tableelement("Employee"; "Employee")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'PositionMenu';
                UseTemporary = false;
                textelement(Ime)
                {
                    MinOccurs = Zero;
                }
                textelement(Prezime)
                {
                    MinOccurs = Zero;
                }
                textelement(JMBG)
                {
                    MinOccurs = Zero;
                }
                textelement(Spol)
                {
                    MinOccurs = Zero;
                }
                textelement(Org)
                {
                    MinOccurs = Zero;
                }
                textelement(Pozicija)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    Employee.Init;

                    Code2 := '';
                    Code3 := '';

                    HumanResSetup.GET;
                    HumanResSetup.TESTFIELD("Employee Nos.");
                    NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", '', 0D, Code2, Code3);

                    Employee."First Name" := Ime;
                    Employee."Last Name" := Prezime;
                    if Spol = 'F' then
                        Employee.Gender := Employee.Gender::Female
                    else
                        Employee.Gender := Employee.Gender::Male;

                    Employee."Employee ID" := JMBG;

                    Employee.Insert();

                    AlternativeAddress.Init();
                    AlternativeAddress.Validate("Employee No.", Employee."No.");
                    AlternativeAddress.Validate(Address, 'Zagrebačka 27');
                    AlternativeAddress.Validate("Municipality Code CIPS", '079');
                    AlternativeAddress.Insert();

                    EmployeeContract.Init();
                    EmployeeContract.Validate("Employee No.", Employee."No.");
                    EmployeeContract.Validate("Org. Structure", 'SIST 1');
                    EmployeeContract.Validate("Reason for Change", EmployeeContract."Reason for Change"::Migration);

                    Department.Reset();
                    Department.SetFilter(Description, '%1', Org);
                    if Department.FindFirst() then begin
                        if Department."Department Type".AsInteger() in [1, 2, 5] then
                            EmployeeContract.Validate("Sector Description", Department.Description);
                        if Department."Department Type".AsInteger() = 3 then
                            EmployeeContract.Validate("Department Cat. Description", Department.Description);
                        if Department."Department Type".AsInteger() = 4 then
                            EmployeeContract.Validate("Group Description", Department.Description);
                        EmployeeContract.Validate("Org Unit Name", 'KJKP “Sarajevogas” d.o.o. Sarajevo');
                        EmployeeContract.Validate("Position Description", Pozicija);
                        EmployeeContract.Validate("Starting Date", 20220101D);

                        EmployeeContract.Insert();
                    end;




                END;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE('Završeno, sada ažuriranje velikih i malih slova');
        EmployeeU.Reset();
        //ĐKEmployeeU.SetFilter(Order, '<=%1', 15);
        if EmployeeU.FindSet() then
            repeat
                EmployeeU."First Name" := CopyStr(EmployeeU."First Name", 1, 1) + LowerCase(copystr(EmployeeU."First Name", 2, StrLen(EmployeeU."First Name")));
                EmployeeU."Last Name" := CopyStr(EmployeeU."Last Name", 1, 1) + LowerCase(copystr(EmployeeU."Last Name", 2, StrLen(EmployeeU."Last Name")));

                Evaluate(Redoslijed, EmployeeU."No.");
                EmployeeU.Order := Redoslijed;
                EmployeeU.Modify();
                EmployeeContract.Reset();
                EmployeeContract.SetFilter("Employee No.", '%1', EmployeeU."No.");
                if EmployeeContract.FindSet() then
                    repeat
                        EmployeeContract."Employee Name" := EmployeeU."First Name" + ' ' + EmployeeU."Last Name";
                        EmployeeContract.Modify();
                    until EmployeeContract.Next() = 0;

            until EmployeeU.Next() = 0;

    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        Redoslijed: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        AlternativeAddress: Record "Alternative Address";

        Department: Record Department;
        Slozen: Decimal;
        EmployeeU: Record Employee;
        Code2: Code[20];
        Code3: Code[20];
        HumanResSetup: Record "Human Resources Setup";
        Uslov: Decimal;

        Odgovor: Decimal;
}

