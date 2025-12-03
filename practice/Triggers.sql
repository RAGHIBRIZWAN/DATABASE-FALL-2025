create table products(
    id int primary key,
    name varchar(20),
    price int,
    stock int,
    subtotal int,
    last_updated date,
    created_by varchar(20),
    updated_by varchar(20)
);

create or replace trigger prevent_negative_values
before insert or update on products
for each row 
enable
begin
    IF :NEW.price <= 0 OR :NEW.stock <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Product price or product quantity cannot be negative or zero');
    END IF;
        
    if :NEW.stock < 5 then
        RAISE_APPLICATION_ERROR(-20002, 'The product is going out of stock');
    end if;
    
    if updating AND :OLD.stock IS NOT NULL AND :NEW.stock < :OLD.stock then
        IF (:OLD.stock - :NEW.stock) > (:OLD.stock * 0.5) THEN
            RAISE_APPLICATION_ERROR(-20003, 'Stock reduction exceeds allowed limit (50%)');
        END IF;
    end if;
    
    :NEW.subtotal := :NEW.price * :NEW.stock;
    
    if UPDATING('subtotal') then
        IF :NEW.subtotal != (:NEW.price * :NEW.stock) THEN 
           RAISE_APPLICATION_ERROR(-20004, 'SUBTOTAL is automatically calculated and allowed only to be set by the trigger.');
        END IF;
    end if;
    
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.last_updated := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.updated_by := USER;
        :NEW.last_updated := SYSDATE;
    END IF;
END;
/

insert into products(id,name,price,stock) values(1,'pen',100,10);
insert into products(id,name,price,stock,subtotal) values(2,'eraser',50,12,100);
    
