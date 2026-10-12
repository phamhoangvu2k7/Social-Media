--liquibase formatted sql

--changeset facebook_team:1-create-friendships-table
CREATE TABLE friendships (
    id UUID PRIMARY KEY,
    requester_id UUID NOT NULL,
    addressee_id UUID NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_friendships_requester FOREIGN KEY (requester_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_friendships_addressee FOREIGN KEY (addressee_id) REFERENCES users(id) ON DELETE CASCADE,

    CONSTRAINT chk_friendships_not_self CHECK ( requester_id <> addressee_id )
);

--changeset facebook_team:2-add-indexes-for-friendships
CREATE UNIQUE INDEX uq_friendships_pair
    ON friendships (
        LEAST(requester_id::text, addressee_id::text),
        GREATEST(requester_id::text, addressee_id::text)
    );

CREATE INDEX idx_friendships_requester_status ON friendships(requester_id, status);
CREATE INDEX idx_friendships_addressee_status ON friendships(addressee_id, status);